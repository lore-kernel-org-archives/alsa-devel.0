From: Carlo Wood <carlo@alinoe.com>
Subject: OSS layer still doesn't ignore xruns.
Date: Thu, 17 Jul 2003 00:44:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030716224431.GA24371@alinoe.com>
References: <20030715120100.GA20739@alinoe.com> <Pine.LNX.4.44.0307152022090.27533-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307152022090.27533-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2003 at 08:31:50PM +0200, Jaroslav Kysela wrote:
> I looked to the problem and it seems that the overrun state is handled 
> differently in the OSS API than ALSA implemented. It seems that the stream 
> is not stopped but rather the oldest period (fragment) is discarded.
> 
> The new code (plus some optimization) is in the ALSA CVS tree. The patch 
> is attached to this e-mail.

This patch does not solve the problem.
As soon as the buffers runs exactly full - which is now a coincidence,
but happens reasonable quickly, the alsa layer detects an "overrun"
and stops the stream.

The stream is then still not restarted.

Attached is the source code of a slightly adjusted
test case that shows the problem.

Example output of attached test code:

>a.out
    Allocated 2 buffers of 1024 bytes.
    Allocated 2 buffers of 2048 bytes.
    Allocated 2 buffers of 4096 bytes.
    Successfully allocated a buffer that is large enough.
    Available bytes: 0
    Available bytes: 1632
    Available bytes: 3264
    Available bytes: 4896
    Available bytes: 6528
    Available bytes: 8160
    Available bytes: 5696
    Available bytes: 7328
    Available bytes: 4864
    Available bytes: 6496
    Available bytes: 8128
    Available bytes: 5664
    Available bytes: 7296
    Available bytes: 4832
    Available bytes: 6464
    Available bytes: 8096
    Available bytes: 5632
    Available bytes: 7264
    Available bytes: 4800
    Available bytes: 6432
    Available bytes: 8064
    Available bytes: 5600
    Available bytes: 7232
    Available bytes: 4768
    Available bytes: 6400
    Available bytes: 8032
    Available bytes: 5568
    Available bytes: 7200
    Available bytes: 4736
    Available bytes: 6368
    Available bytes: 8000
    Available bytes: 5536
    Available bytes: 7168
    Available bytes: 4704
    Available bytes: 6336
    Available bytes: 7968
    Available bytes: 5504
    Available bytes: 7136
    Available bytes: 4672
    Available bytes: 6304
    Available bytes: 7936
    Available bytes: 5472
    Available bytes: 7104
    Available bytes: 4640
    Available bytes: 6272
    Available bytes: 7904
    Available bytes: 5440
    Available bytes: 7072
    Available bytes: 4608
    Available bytes: 6240
    Available bytes: 7872
    Available bytes: 5408
    Available bytes: 7040
    Available bytes: 4576
    Available bytes: 6208
    Available bytes: 7840
    Available bytes: 5376
    Available bytes: 7008
    Available bytes: 4544
    Available bytes: 6176
    Available bytes: 7808
    Available bytes: 5344
    Available bytes: 6976
    Available bytes: 4512
    Available bytes: 6144
    Available bytes: 7776
    Available bytes: 5312
    Available bytes: 6944
    Available bytes: 4480
    Available bytes: 6112
    Available bytes: 7744
    Available bytes: 5280
    Available bytes: 6912
    Available bytes: 4448
    Available bytes: 6080
    Available bytes: 7712
    Available bytes: 5248
    Available bytes: 6880
    Available bytes: 4416
    Available bytes: 6048
    Available bytes: 7680
    Available bytes: 5216
    Available bytes: 6848
    Available bytes: 4384
    Available bytes: 6016
    Available bytes: 7648
    Available bytes: 5184
    Available bytes: 6816
    Available bytes: 4352
    Available bytes: 5984
    Available bytes: 7616
    Available bytes: 5152
    Available bytes: 6784
    Available bytes: 4320
    Available bytes: 5952
    Available bytes: 7584
    Available bytes: 5120
    Available bytes: 6752
    Available bytes: 4288
    Available bytes: 5920
    Available bytes: 7552
    Available bytes: 5088
    Available bytes: 6720
    Available bytes: 4256
    Available bytes: 5888
    Available bytes: 7520
    Available bytes: 5056
    Available bytes: 6688
    Available bytes: 4224
    Available bytes: 5856
    Available bytes: 7488
    Available bytes: 5024
    Available bytes: 6656
    Available bytes: 4192
    Available bytes: 5824
    Available bytes: 7456
    Available bytes: 4992
    Available bytes: 6624
    Available bytes: 4160
    Available bytes: 5792
    Available bytes: 7424
    Available bytes: 4960
    Available bytes: 6592
    Available bytes: 4128
    Available bytes: 5760
    Available bytes: 7392
    Available bytes: 4928
    Available bytes: 6560
    Available bytes: 8192
    Successfully caused an xrun.
    non-blocking fragments: 2
    non-blocking bytes: 8192
    Available bytes in buffer: 5728
    Additionally read 1024 bytes.
    Additionally read 1024 bytes.
    Additionally read 1024 bytes.
    Additionally read 1024 bytes.
    Stream is not restarted after xrun.

-- 
Carlo Wood <carlo@alinoe.com>

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testcode.c"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/soundcard.h>
#include <time.h>

int main(void)
{
  int fd;
  int res = 0x7fff0009;
  audio_buf_info info;
  int prev_size = 0;
  do
  {
    ++res;
    close(fd);
    fd = open("/dev/dsp", O_RDONLY);
    if (fd == -1) { perror("open"); exit(127); }
    if (ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &res) == -1) {
      perror("ioctl"); exit(127); }
    if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
      perror("read"); exit(127); }
    printf("    Allocated %d buffers of %d bytes.\n", info.fragstotal, info.fragsize);
    if (prev_size == info.fragsize * info.fragstotal)
    {
      printf("    It seems impossible to set a recording buffer with a\n"
             "    total size of at least 8192 bytes.  This is not going\n"
             "    to work with ViaVoice.  Sorry.\n");
      exit(126);
    }
    prev_size = info.fragsize * info.fragstotal;
  }
  while (prev_size < 8192);
  printf("    Successfully allocated a buffer that is large enough.\n");
  res = AFMT_S16_LE;
  if (ioctl(fd, SNDCTL_DSP_SETFMT, &res) == -1) {
    perror("ioctl"); exit(127); }
  res = 0;
  if (ioctl(fd, SNDCTL_DSP_STEREO, &res) == -1) {
    perror("ioctl"); exit(127); }
  res = 22050;
  if (ioctl(fd, SOUND_PCM_READ_RATE, 0xbfffdcfc) == -1) {
    perror("ioctl"); exit(127); }
  char buf[1024];
  if (read(fd, buf, sizeof(buf)) < 0) { perror("read"); exit(127); }
  static struct timespec naptime = { 0, 100000000 };
  do {
    if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
      perror("read"); exit(127); }
    printf("    Available bytes: %d\n", info.bytes);
    nanosleep(&naptime, 0);
  } while(info.bytes < info.fragsize * info.fragstotal);
  printf("    Successfully caused an xrun.\n");
  printf("    non-blocking fragments: %d\n", info.fragments);
  printf("    non-blocking bytes: %d\n", info.bytes);
  ssize_t bufsize = info.bytes;
  if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
    perror("read"); exit(127); }
  printf("    Available bytes in buffer: %d\n", info.bytes);
  ssize_t trlen = 0;
  int nf = 0;
  for (;;)
  {
    if (info.fragments > 0) {
      ssize_t rlen;
      if ((rlen = read(fd, buf, sizeof(buf))) < 0)
      { perror("read"); exit(127); }
      printf("    Additionally read %d bytes.\n", rlen);
      trlen += rlen;
      if (trlen > bufsize) {
        printf("    Read %d bytes: stream successfully restarted.\n", trlen);
        break;
      }
      nf = 0;
    }
    else if (++nf > 10) {
      printf("    Stream is not restarted after xrun.\n");
      exit(1);
    }
    if (ioctl(fd, SNDCTL_DSP_GETISPACE, &info) == -1) {
      perror("read"); exit(127); }
  }
  close(fd);
  return 0;
}


--u3/rZRmxL6MmkK24--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
