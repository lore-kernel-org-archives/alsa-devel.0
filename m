From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Fri, 20 Sep 2002 12:04:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8AF2BE.360C7AEC@ladisch.de>
References: <Pine.LNX.4.31.0209191923430.30429-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> > Fedor G. Pikus wrote:
> > > > > > > arecord: pcm_read:1049: read error: Input/output error
> > >
> > > Still nothing in the log, even with --with-debug=full
> 
> I built arecord and libasound with debug and went into it with gdb.
> I traced it to the function static snd_pcm_sframes_t snd_pcm_hw_readi(...)
> in pcm_hw.c line 525. There, it makes a call to
> result = ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi);
> and pauses for a few seconds. When ioctl returns, result == -1,
> size == 5, xferi == {result = -5, buf = 0x805a470, frames = 4096},
> and errno == 5 (EIO according to asm/include.h, the man page for ioctl does
> not even list it among valid error codes). The function immediately returns,
> and arecord exits.

If the pause is 10 seconds, the error may have been returned by the following
code in snd_pcm_lib_read1:

	if (schedule_timeout(10 * HZ) == 0) {
		state = ... EXPIRED;
		break;
	}
	...
	case EXPIRED:
		snd_printd("capture read error (DMA or IRQ trouble?)\n");
		err = -EIO;

Or is the pause 5 seconds (the timeout of usb_set_interface)?

	if (usb_set_interface(dev, subs->interface, fmt->altset_idx) < 0) {
		snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed\n",
			   dev->devnum, subs->interface, fmt->altsetting);
		return -EIO;
	}

Are you _really_ sure you have recompiled the entire alsa-driver package
with debug output, installed it correctly, and there's nothing in the log?

Please try inserting the line

	snd_printk(KERN_ERR "now calling usb_set_interface ...\n");

immediately before the line with usb_set_interface in usbaudio.c. This
message must always be visible in the log.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
