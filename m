From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Fwd: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Tue, 7 Jul 2009 11:51:17 +0200
Message-ID: <200907071151.17477.nutz@unfoog.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 942EF246F6
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 11:51:17 +0200 (CEST)
Received: from panama.localnet (port-87-234-90-241.dynamic.qsc.de
	[87.234.90.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.unfoog.de (Postfix) with ESMTPSA id 326F238BE45
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 11:51:10 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 July 2009 08:00:19 you wrote:
> At Mon, 6 Jul 2009 22:14:56 +0200,
>
> Andreas N=FC=DFlein wrote:
> > On Monday 06 July 2009 21:26:18 you wrote:
> > > At Mon, 06 Jul 2009 11:16:35 -0600,
> > >
> > > Sean Burke wrote:
> > > > Scr=EDobh Takashi Iwai:
> > > > > At Mon, 6 Jul 2009 17:53:46 +0200,
> > > > >
> > > > > Andreas N=FC=DFlein wrote:
> > > > >>> The missing pin configuration initialization was already fixed =
by
> > > > >>> the driver overriding it after checking PCI SSID (which is
> > > > >>> different from the codec SSID).  So, this should be no problem.
> > > > >>>
> > > > >>> However, the reason why the analog output doesn't work might be
> > > > >>> different from that.  There might be something else missing, but
> > > > >>> I don't know.
> > > > >>>
> > > > >>>
> > > > >>> Takashi
> > > > >>
> > > > >> oh =3D(
> > > > >>
> > > > >>
> > > > >> hmm.. anything i can do?  would it help if i tried changing valu=
es
> > > > >> randomly with hda-analyzer.py?
> > > > >
> > > > > Well, did the driver without my change work more or less with
> > > > > the analog audio, or have you never gotten the analog output?
> > > > > You can use the generic parser (i.e. the state without cirrus
> > > > > patch) by passing model=3Dgeneric option to snd-hda-intel.
> > > >
> > > > For my part, nothing worked with the generic driver. I can't confirm
> > > > digital out, but I can confirm that the kfree error is gone. What
> > > > options are open for figuring out what remains?
> > >
> > > Easy things to test are GPIO bits.  Run hda-verb like
> > >
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x0f
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x0f
> > > or
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0f
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x0f
> > >
> > > etc.  CS4206 seems to have 4 GPIO lines, and each bit (0-3)
> > > corresponds to each GPIO.  In many case, GPIO0 or GPIO1 corresponds to
> > > the amplifier (EAPD) bit.
> > > Define the GPIO direction of each GPIO bit by SET_GPIO_DIR, and
> > > turn on/off the GPIO bits by SET_GPIO_DATA.  Running
> > > 	hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0
> > > will show the current GPIO data bits.  Or you can check it in codec#*
> > > proc file.
> > >
> > >
> > > Takashi
> >
> > w000000000000000000000000000000000t! =3D)
> >
> > takashi, thank you _so_ much!
> >
> > after running all 4 of those:
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x0f
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x0f
> > > or
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0f
> > > 	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x0f
> >
> > i suddendly had sound!! :D :D :D :D :D :D :D
> > only via speakers  though - there is no sound via headphones right now.
> >
> > mixer channels:
> > - Master (with Mutebutton), PCM and Front (also with Mute) all work =3D)
> > - i don't know what surround would do (or it's extra switch)
> > - headphones-volumes and mute button don't affect the speakers, which is
> > good =3D)
> >
> >
> > is there a way to reset what i did with hda-verb, so that i can figure
> > out which combination it was exactly?
>
> You can just change the value 0x0f to a different value.
> At least, you can try commands like
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x08
> and check the speaker output at each time.
> Also, check the GPIO direction,
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x02
>  	hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02
> 	...
>
> Regarding the headphone: is the speaker muted when you plug in the
> headphone?  If not, it's likely an issue of the jack detection.  If
> the speaker is muted but no headphone output, it's a missing
> initialization (or wrong GPIO setup).
>
>
> Takashi


so here are my findings so far:

hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x08


is sufficient to turn on the right functionality for the speakers; meaning:
 - 'front speaker'-channel actually controls the two front speakers within =
the
   macbookpro - even controlling left and right channel seperately works  =
=3D)
 - 'surround' mute-switch and volume-control (why are those not within on
   thing btw?) also work and control a third speaker in the mac, which
   really seems responsibly for surround :)

headphones do not yet work, however i made a diff of =

"/proc/asound/card0/codec#0" with and without something plugged in:

$ diff -u without_headphones.txt with_headphones.txt
--- without_headphones.txt      2009-07-07 11:41:36.558833270 +0200
+++ with_headphones.txt 2009-07-07 11:41:44.286832992 +0200
@@ -113,7 +113,7 @@
     Conn =3D Unknown, Color =3D Unknown
     DefAssociation =3D 0x2, Sequence =3D 0x1
     Misc =3D NO_PRESENCE
-  Pin-ctls: 0x40: OUT
+  Pin-ctls: 0x00:
   Unsolicited: tag=3D00, enabled=3D0
   Power: setting=3DD0, actual=3DD0
   Delay: 1 samples
@@ -125,7 +125,7 @@
     Conn =3D Unknown, Color =3D Unknown
     DefAssociation =3D 0x2, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
-  Pin-ctls: 0x40: OUT
+  Pin-ctls: 0x00:
   Delay: 1 samples
   Connection: 1
      0x04



thanks =3D)
nutz
