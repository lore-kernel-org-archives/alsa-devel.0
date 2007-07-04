From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: Re: another device for opl3sa2
Date: Tue, 3 Jul 2007 19:24:23 -0700
Message-ID: <20070704022423.GA2012@math.berkeley.edu>
References: <20070703002739.GA27389@math.berkeley.edu>
	<s5hfy45ajk1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9933B24463
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 04:24:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfy45ajk1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 03, 2007 at 12:05:50PM +0200, Takashi Iwai wrote:
> At Mon, 2 Jul 2007 17:27:39 -0700,
> Paul Vojta wrote:
> > 
> > Folks:
> > 
> > Here's a patch to add support for an (admittedly old) device:
> > 
> > 
> > --- linux-2.6.21.5/sound/isa/opl3sa2.c.orig	2007-06-11 11:37:06.000000000 -0700
> > +++ linux-2.6.21.5/sound/isa/opl3sa2.c	2007-06-30 23:29:43.000000000 -0700
> > @@ -165,6 +165,8 @@
> >  	{ .id = "YMH0801", .devs = { { "YMH0021" } } },
> >  	/* NeoMagic MagicWave 3DX */
> >  	{ .id = "NMX2200", .devs = { { "YMH2210" } } },
> > +	/* NeoMagic MagicWave 3D */
> > +	{ .id = "NMX2200", .devs = { { "NMX2210" } } },
> >  	/* --- */
> >  	{ .id = "" }	/* end */
> >  };
> > 
> 
> Thanks, could you give your sign-off?

Description:

	Add Neomagic MagicWave 3D to list of supported devices for opl3sa2
	driver.

Signed-off by:  Paul Vojta <vojta at math.berkeley.edu>


> > (There may be a bug in the initialization code, though -- it doesn't work
> > the first time after booting, just the second and subsequent times.
> > For example, the first time I try running "aplay file.wav" it'll sit there
> > silently instead of playing the file, but if I type "aplay file.wav" again
> > then it'll play.)
> 
> What do you mean "doesn't work"?  The module wasn't loaded or
> malfunctional?

The driver was malfunctional the first time after reboot or rmmod+modprobe.

aplay would give all appearances of working, and waited the proper amount
of time, but did not produce sound.  It was as if the sound was played at
volume zero.

Second and subsequent invocations of aplay worked properly.

> > I don't know whether snd_opl3sa2_pnpbiosids[] should also be changed.
> 
> The table you changed is for ISA-PnP, while *_pnpbiosids[] is for PnP
> BIOS.  There are slight differences.  And, "NMX2210" is already
> there.

Oops, sorry.

> > Also, why does nm256.c direct users to the cs423x drivers and not opl3sa2?
> > If it had mentioned opl3sa2 it would have saved me many hours.
> 
> Patch please?  Also, it'd be better to fix ALSA-Configuration.txt,
> too...

ALSA-Configuration.txt already mentions opl3sa2.

For nm256.c:

Description:

	Adds mention of opl3sa2 driver to a diagnostic message for
	NeoMagic nm256 driver.

Signed-off by:  Paul Vojta <vojta at math.berkeley.edu>

--- a/sound/pci/nm256/nm256.c	2007-06-11 11:37:06.000000000 -0700
+++ b/sound/pci/nm256/nm256.c	2007-07-03 13:00:11.000000000 -0700
@@ -1533,7 +1533,8 @@
 				printk(KERN_ERR "  force the driver to load by "
 				       "passing in the module parameter\n");
 				printk(KERN_ERR "    force_ac97=1\n");
-				printk(KERN_ERR "  or try sb16 or cs423x drivers instead.\n");
+				printk(KERN_ERR "  or try sb16, opl3sa2, or "
+				       "cs423x drivers instead.\n");
 				err = -ENXIO;
 				goto __error;
 			}


Sincerely,


Paul Vojta
vojta@math.berkeley.edu
