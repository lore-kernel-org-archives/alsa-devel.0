From: Antonio Willy Malara <behappy@maialone.com>
Subject: again on the us-x2y
Date: Thu, 04 Nov 2004 14:58:41 +0000
Message-ID: <1099580321l.2337l.0l@Zeryn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-82IO09u1yAmEMERhxR0s"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vsmtp2.tin.it (vsmtp2alice.tin.it [212.216.176.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D5328228
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2004 16:12:20 +0100 (MET)
Received: from Zeryn (80.182.94.62) by vsmtp2.tin.it (7.0.027)
        id 4188DF580008DC0A for alsa-devel@alsa-project.org; Thu, 4 Nov 2004 16:12:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-82IO09u1yAmEMERhxR0s
Content-Type: text/plain; charset=ISO-8859-15; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i've been off from the discussion for a while, been busy with moving, =20
now i seen that the ohci issue is solved, but the lastest driver wont =20
work for me, i attach the log jackd and the kernel give me

however i can run jack and alsa apps with this card with the 0.8.3a, =20
jack with his oss driver, using the alsa emulation driver, and apps =20
like mplayer of rhythmbox directly to the alsa driver

wil
---
Il jazz e' lasciare che la luce brilli, lasciarla essere.
		-- Keith Jarrett


--=-82IO09u1yAmEMERhxR0s
Content-Type: text/plain; charset=us-ascii; name=errorlog
Content-Disposition: attachment; filename=errorlog
Content-Transfer-Encoding: quoted-printable

ckd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ... plughw:0|plughw:0|1024|2|48000|0|0|nomon|swmeter|-=
|32bit
control device hw:0
configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a hardware device
instead rather than using the plug layer. Usually the name of the
hardware device that corresponds to the first soun
usx2yaudio.c:785:snd_usX2Y_hw_params(c225d520, c729f400)
usx2yaudio.c:861:snd_usX2Y_pcm_prepare(c225d520)
usx2yaudio.c:394:usX2Y_substream_prepare(c10b6a60) ep=3D8 urb0=3D00000000 u=
rb1=3D00000000
usx2yaudio.c:874:starting capture pipe for self
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a hardware device
instead rather than using the plug layer. Usually the name of the
hardware device that corresponds to the first soun
usx2yaudio.c:785:snd_usX2Y_hw_params(c225d3a0, c7b67800)
usx2yaudio.c:861:snd_usX2Y_pcm_prepare(c225d3a0)
usx2yaudio.c:394:usX2Y_substream_prepare(c10b6be0) ep=3D10 urb0=3D00000000 =
urb1=3D00000000
Sequence Error!(hcd_frame=3D7061 ep=3D10out;wait=3D7059,frame=3D7058).
Most propably some urb of usb-frame 7059 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.
usx2yaudio.c:281:0 c10b6be0 state=3D4
usx2yaudio.c:281:1 c10b6a60 state=3D4
usx2yaudio.c:294:0 status=3D0 start_frame=3D7058
usx2yaudio.c:294:1 status=3D-115 start_frame=3D7061
usx2yaudio.c:294:0 status=3D-115 start_frame=3D7059
usx2yaudio.c:294:1 status=3D-115 start_frame=3D7062
usx2yaudio.c:325:hcd_frame=3D7063 ep=3D8in status=3D0 start_frame=3D7059
usx2yaudio.c:281:0 c10b6be0 state=3D0
usx2yaudio.c:281:1 c10b6a60 state=3D0
usx2yaudio.c:294:0 status=3D0 start_frame=3D7058
usx2yaudio.c:294:1 status=3D-115 start_frame=3D7061
usx2yaudio.c:325:hcd_frame=3D7064 ep=3D10out status=3D0 start_frame=3D7061
usx2yaudio.c:294:0 status=3D0 start_frame=3D7059
usx2yaudio.c:294:1 status=3D-115 start_frame=3D7062
usx2yaudio.c:325:hcd_frame=3D7065 ep=3D8in status=3D0 start_frame=3D7062
ALSA lib pcm_hw.c:521:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: =
Broken pipe
ALSA: cannot set hardware parameters for playback
ALSA: cannot configure playback channel
usx2yaudio.c:826:snd_usX2Y_hw_free(c225d520)
usx2yaudio.c:418:usX2Y_urbs_release() 8
usx2yaudio.c:826:snd_usX2Y_hw_free(c225d520)
usx2yaudio.c:418:usX2Y_urbs_release() 8
usx2yaudio.c:826:snd_usX2Y_hw_free(c225d3a0)
usx2yaudio.c:418:usX2Y_urbs_release() 10
usx2yaudio.c:418:usX2Y_urbs_release() 8
usx2yaudio.c:826:snd_usX2Y_hw_free(c225d3a0)
usx2yaudio.c:418:usX2Y_urbs_release() 10
usx2yaudio.c:418:usX2Y_urbs_release() 8
cannot load driver module alsa
Zeryn:/home/willy/Pacchi/linux/linux-2.6.9#



--=-82IO09u1yAmEMERhxR0s--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
