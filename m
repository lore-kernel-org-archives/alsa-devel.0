From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: usb-audio
Date: Tue, 28 Oct 2003 20:18:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310282018.35309.bergtroll@gmx.li>
References: <20031027180300.GA5016@Zeryn> <s5hwuap4hk6.wl@alsa2.suse.de> <s5had7l43tm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had7l43tm.wl@alsa2.suse.de>
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

Here we go again,

Am Dienstag, 28. Oktober 2003 19:25 schrieb Takashi Iwai:

> > hmm, then something wrong in the converter routine...
> > needs to take a deeper look.
>
> i found a bug regarding the plugin but it must be another bug from the
> above problem.
>
> segfault is a bit puzzling.  could you try the attached patch to see
> the parameters?  or, even better, check the values in gdb's
> backtrace.

Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
Video: no video
Starting playback...
XXX linear_convert: dst=0x104d3dc0/0, src=0x7fffc020/0, ch=2, 
frames=16384, idx=35

===========
gdb:

Starting playback...
XXX linear_convert: dst=0x104d1f18/0, src=0x7fffcf40/0, ch=2, 
frames=16384, idx=       35

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 14666)]
snd_pcm_linear_convert (dst_areas=0x104d1f18, dst_offset=0, 
    src_areas=0x7fffcf40, src_offset=0, channels=2, frames=16384, 
convidx=35)
    at plugin_ops.h:299
299     conv_1234_xx21: as_u16(dst) = bswap_16(as_u32c(src) >> 16); goto 
CONV_EN       D;
(gdb) bt
#0  snd_pcm_linear_convert (dst_areas=0x104d1f18, dst_offset=0, 
    src_areas=0x7fffcf40, src_offset=0, channels=2, frames=16384, 
convidx=35)
    at plugin_ops.h:299
#1  0x0fd4326c in snd_pcm_linear_convert (dst_areas=0x104d1f18, 
dst_offset=0, 
    src_areas=0x7fffcf40, src_offset=0, channels=2, frames=16384, 
convidx=35)
    at pcm_linear.c:170
#2  0x0fd41838 in snd_pcm_plugin_write_areas (pcm=0x0, areas=0x7fffcf40, 
    offset=2, size=2147471168) at pcm_plugin.c:365
#3  0x0fd37dc4 in snd_pcm_write_areas (pcm=0x23, areas=0x104db86c, 
offset=2, 
    size=2147471168, func=0) at pcm.c:6206
#4  0x0fd41c44 in snd_pcm_plugin_writei (pcm=0x104d1f18, buffer=0x4, 
    size=2147471168) at pcm_plugin.c:436
#5  0x0fd30c6c in snd_pcm_writei (pcm=0x0, buffer=0x0, size=0)
    at pcm_local.h:368
#6  0x10078718 in outputaudio ()
#7  0x1007837c in outputaudio ()
#8  0x1002ed74 in main ()
==================================


>
>
> also, what happens if running mplayer with mmap option, i.e.
>
> 	% mplayer -ao alsa9:emi26:mmap
>
horrible, distorted sound: (sounds like computer is too slow to deliver 
the samples)
ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Die 
Dateizugriffsnummer ist ein schlechter Verfassung 

meaning: "File descriptor in bad state" (whoever sneaked in this 
translation...)

Have fun

Niklas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
