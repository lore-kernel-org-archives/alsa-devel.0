From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: SOLVED = RE: Alsa & 2.6 kernel
Date: Fri, 26 Sep 2003 07:50:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKEAODFAB.mknecht@controlnet.com>
References: <s5hbrt7kh9o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrt7kh9o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
> right.
>
>  * linux/sound/oss = the old good real OSS drivers, which was located
>                      at linux/drivers/sound on 2.4 tree.
>                      (i mean here OSS is not genuine OSS by 4front but
>                       so-called OSS/Free or OSS/Kernel.)
>
>  * linux/sound/core/oss = ALSA OSS emulation modules, namely,
>                      snd-pcm-oss and snd-mixer-oss modules.
>
> in addition, in linux/sound directory, you'll find two files which
> were originally in linux/drivers/sound on 2.4 kernel: sound_core.c and
> sound_firmware.c.  since these files are the common base for both ALSA
> and OSS, they are put there.  and they can be found in alsa-kernel
> tree, too, indeed.

Good description. Thanks.

>
> > The right answer (in my mind) is that I should be able to delete the oss
> > directory in linux/sound, not enable OSS Sound support when I
> configure the
> > kernel, and still get OSS emulation support from Alsa. I hope I have not
> > been incorrect about this.
>
> oh, don't remove the contents under linux/sound/oss.  since the kernel
> configurator needs the files (at least linux/sound/oss/Kconfig), you
> should keep them as they are.

Certainly. I was speaking more figuratively. I wouldn't actually remove
anything having to do with OSS, but wanted to be more clear what is what.

> :)
>
> well, if you want to try an experimental driver on 2.6, too, you'll
> need build alsa-drivers tree.  as long as you need only the drivers
> already existing on linux kernel tree, this is not necessary.

I built and booted the Gentoo 2.6.0-test5 development kernel last night. It
brought up Alsa, according to the boot time list of things going on. lsmod
showed only about 4 drivers loaded, where as with 2.4 I'm used to seeing
about 15. I think possibly I did not build in support for both my onboard
sound chip as well as the HDSP 9652, and I think the USB options didn't work
correctly as my UPS was not discovered at boot time and the apcupsd daemon
did not start.

I'll look at all of this in the upcoming week or two and see if I can get
2.6 actually working.

Thanks for your time and for sharing your experience.

- Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
