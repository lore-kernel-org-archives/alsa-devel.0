From: Carlo Wood <carlo@alinoe.com>
Subject: OSS layer doesn't ignore xruns.
Date: Tue, 15 Jul 2003 14:01:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030715120100.GA20739@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Is someone looking into my report please?

I did include a compilable test case, so it shouldn't
be too hard to reproduce this :/

Myself, I am using a Creative SoundBlaster Live! value,
but I think this should give the same results with any
sound card.

Using kernel 2.5.74 here.

The previous post:

On Sun, Jul 13, 2003 at 05:59:19PM +0200, Carlo Wood wrote:
> On Sun, Jul 13, 2003 at 04:38:47AM +0200, Carlo Wood wrote:
> > I wrote a patch for sound/core/oss/pcm_oss.c, that fixes the ViaVoice
> > problem.
> 
> Later I wrote a test case that still doesn't get fixed:
> 
> >a.out
>     Size of a fragment in bytes: 1024
>     Allocated fragments for buffering: 2
>     Successfully caused an xrun.
>     non-blocking fragments: 2
>     non-blocking bytes: 2048
>     Stream is not restarted after xrun.
> 
> now this is expected without my patch, but with
> the patch the stream *is* set back to a RUNNING state
> again successfully - nevertheless, snd_pcm_update_hw_ptr_interrupt
> is not called anymore.
> 
> Is there anyone who can get the following test code to work
> (by patching the ALSA kernel module, not by changing the test code! ;).
> 
> Test code:
> 
> 
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
> #include <sys/soundcard.h>
> #include <time.h>
> 
> int main(void)
> {
>   int fd = open("/dev/dsp", O_RDONLY);
>   if (fd == -1) { perror("open"); exit(127); }
>   int res = AFMT_S16_LE;
>   if (ioctl(fd, SNDCTL_DSP_SETFMT, &res) == -1) {
>     perror("ioctl"); exit(127); }
>   res = 0;
>   if (ioctl(fd, SNDCTL_DSP_STEREO, &res) == -1) {
>     perror("ioctl"); exit(127); }
>   res = 22050;
>   if (ioctl(fd, SOUND_PCM_READ_RATE, 0xbfffdcfc) == -1) {
>     perror("ioctl"); exit(127); }
>   res = 0x7fff000a;
>   if (ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &res) == -1) {
>     perror("ioctl"); exit(127); }
>   audio_buf_info info;
>   if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
>     perror("read"); exit(127); }
>   printf("    Size of a fragment in bytes: %d\n", info.fragsize);
>   printf("    Allocated fragments for buffering: %d\n", info.fragstotal);
>   char buf[1024];
>   if (read(fd, buf, sizeof(buf)) < 0) { perror("read"); exit(127); }
>   static struct timespec naptime = { 0, 100000000 };
>   int count = 0;
>   do {
>     if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
>       perror("read"); exit(127); }
>     nanosleep(&naptime, 0);
>     if (++count == 20) { printf("Failed to cause an xrun.\n"); exit(127); }
>   } while(info.bytes < info.fragsize * info.fragstotal);
>   printf("    Successfully caused an xrun.\n");
>   printf("    non-blocking fragments: %d\n", info.fragments);
>   printf("    non-blocking bytes: %d\n", info.bytes);
>   ssize_t bufsize = info.bytes;
>   ssize_t trlen = 0;
>   int nf = 0;
>   for (;;)
>   {
>     if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
>       perror("ioctl"); exit(127); }
>     if (info.fragments > 0) {
>       ssize_t rlen;
>       if ((rlen = read(fd, buf, sizeof(buf))) < 0)
>       { perror("read"); exit(127); }
>       trlen += rlen;
>       if (trlen > bufsize) {
>         printf("    Read %d bytes: stream successfully restarted.\n", trlen);
> 	exit(0);
>       }
>       nf = 0;
>     }
>     else if (++nf > 10) {
>       printf("    Stream is not restarted after xrun.\n");
>       exit(1);
>     }
>   }
>   close(fd);
>   return 0;
> }
> 
> 
> Here is some debug output that I generated with added printk's:
> 
> Jul 13 17:22:27 ansset kernel: Entering snd_pcm_update_hw_ptr_interrupt
> Jul 13 17:22:27 ansset kernel: snd_pcm_update_hw_ptr_interrupt: status->hw_ptr set to 1536
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 1536, control->appl_ptr = 512
> Jul 13 17:22:27 ansset kernel: Calling snd_pcm_stop, runtime->status->state = SNDRV_PCM_STATE_RUNNING
> Jul 13 17:22:27 ansset kernel: Returned from snd_pcm_stop, runtime->status->state = SNDRV_PCM_STATE_XRUN
> Jul 13 17:22:27 ansset kernel: Leaving snd_pcm_update_hw_ptr_interrupt with EPIPE
> ...
> Jul 13 17:22:27 ansset kernel: snd_pcm_oss_read3: calling snd_pcm_kernel_ioctl SNDRV_PCM_IOCTL_DRAIN
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_drain: state is SNDRV_PCM_STATE_XRUN.  Calling snd_pcm_change_state.
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 1536, control->appl_ptr = 512
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_drain: Returning from snd_pcm_change_state, state is now 5
> Jul 13 17:22:27 ansset kernel: Entering snd_pcm_lib_read1
> Jul 13 17:22:27 ansset kernel: state is SNDRV_PCM_STATE_DRAINING
> Jul 13 17:22:27 ansset kernel: size = 512
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 1536, control->appl_ptr = 512
> Jul 13 17:22:27 ansset kernel: Leaving snd_pcm_lib_read1; xfer = 512, err = 0
> ...
> Jul 13 17:22:27 ansset kernel: Entering snd_pcm_lib_read1
> Jul 13 17:22:27 ansset kernel: state is SNDRV_PCM_STATE_DRAINING
> Jul 13 17:22:27 ansset kernel: size = 512
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 1536, control->appl_ptr = 1024
> Jul 13 17:22:27 ansset kernel: Leaving snd_pcm_lib_read1; xfer = 512, err = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status: status->hw_ptr copied to be 1536
> Jul 13 17:22:27 ansset kernel: Calling snd_pcm_capture_avail()
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 1536, control->appl_ptr = 1536
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail returned status->avail = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status_user: status.avail = 0
> 
> [start of effect of my patch]
> 
> Jul 13 17:22:27 ansset kernel: snd_pcm_oss_read3: calling snd_pcm_kernel_ioctl(SNDRV_PCM_IOCTL_PREPARE)
> Jul 13 17:22:27 ansset kernel: snd_pcm_lib_ioctl_reset: status->hw_ptr set to 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_oss_read3: state now SNDRV_PCM_STATE_RUNNING
> Jul 13 17:22:27 ansset kernel: snd_pcm_update_hw_ptr: status->hw_ptr set to 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 0, control->appl_ptr = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status: status->hw_ptr copied to be 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 0, control->appl_ptr = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail returned status->avail = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status_user: status.avail = 0
> Jul 13 17:22:27 ansset kernel: space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
> 
> [end of patch effects]
> 
> ...
> 
> but snd_pcm_update_hw_ptr_interrupt is never called anymore,
> it only repeats
> 
> Jul 13 17:22:27 ansset kernel: snd_pcm_update_hw_ptr: status->hw_ptr set to 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 0, control->appl_ptr = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status: status->hw_ptr copied to be 0
> Jul 13 17:22:27 ansset kernel: Calling snd_pcm_capture_avail()
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 0, control->appl_ptr = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_capture_avail returned status->avail = 0
> Jul 13 17:22:27 ansset kernel: snd_pcm_status_user: status.avail = 0
> Jul 13 17:22:27 ansset kernel: space: bytes = 0, periods = 0, fragstotal = 2, fragsize = 1024
> 
> after that.
> 
> -- 
> Carlo Wood <carlo@alinoe.com>
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps1
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
