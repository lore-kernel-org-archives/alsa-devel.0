From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: [Fwd: ALSA OSS compatibility]
Date: Tue, 11 Feb 2003 14:34:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E48FBEC.76F19F85@libero.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------94CB04C2B374D043B8ED72B3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------94CB04C2B374D043B8ED72B3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Someone can confirm this is the OSS conformant behaviour?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
--------------94CB04C2B374D043B8ED72B3
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <leif.asbrink@mbox300.swipnet.se>
Delivered-To: abramo@igor.opun.it
Received: from localhost (localhost [127.0.0.1])
	by igor.opun.it (Postfix) with ESMTP id 268DEBC1EA
	for <abramo@localhost>; Tue, 11 Feb 2003 14:29:22 +0100 (CET)
Received: from pop.libero.it [193.70.192.70]
	by localhost with IMAP (fetchmail-5.9.11)
	for abramo@localhost (single-drop); Tue, 11 Feb 2003 14:29:22 +0100 (CET)
Received: from smtp5.libero.it (193.70.192.55) by ims5a.libero.it (6.5.028)
        id 3E441225000EB27B for abramo.bagnara@libero.it; Tue, 11 Feb 2003 14:27:15 +0100
Received: from alsa.alsa-project.org (160.217.1.49) by smtp5.libero.it (6.7.015)
        id 3E39A0D1017A6060 for abramo.bagnara@libero.it; Tue, 11 Feb 2003 14:27:15 +0100
Received: from fep04-svc.swip.net (fep04.swip.net [130.244.199.132])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA17133
	for <abramo@alsa-project.org>; Tue, 11 Feb 2003 14:27:13 +0100
Received: from leif ([213.101.23.1]) by fep04-svc.swip.net with SMTP
          id <20030211132709.FSCV24060.fep04-svc.swip.net@leif>
          for <abramo@alsa-project.org>; Tue, 11 Feb 2003 14:27:09 +0100
From: =?iso-8859-1?Q?Leif_=C5sbrink?= <leif.asbrink@mbox300.swipnet.se>
To: <abramo@alsa-project.org>
Subject: ALSA OSS compatibility
Date: Tue, 11 Feb 2003 14:46:42 +0100
Message-ID: <CFEIKLJOPPJLBFPEJHKOOEGPCOAA.leif.asbrink@mbox300.swipnet.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
X-Spam-Status: No, hits=1.0 required=5.0
	tests=LINES_OF_YELLING,SPAM_PHRASE_00_01,USER_AGENT_OUTLOOK
	version=2.43
X-Spam-Level: *

Hi Abramo,

I am working with an SDR (Software Defined Radio) under
Linux which uses soundcards to move part of the radio
spectrum into the PC computer.

I have made this package using OSS but it would of course
be very nice to make it run under ALSA as well.

At the moment ALSA is not compatible to OSS because the
ioctl calls do not behave as specified in the OSS manual.

For example, the following sequence differs between OSS and ALSA:

int speed=3D100000;
ioctl(dv,SNDCTL_DSP_SPEED,&speed);

After this sequence the variable speed contains 48000
or whatever the maximum speed is for the device while
ALSA does not change the value of speed.

The OSS manual explicitly instructs the application programmer
to check the returned speed value to get the actual speed
that the device will use. The OSS API accepts any value between
1Hz and 2 GHz ( 1 to 2000000000) but the lowest/highest possible
sampling rate will be returned by ioctl and used by the device.

I am not a programmer myself, I have a background in physics, so
I use straightforward C and assembly to do digital signal=20
processing. How to modify the ioctl calls and the alsa-oss.c=20
program is beyond my skils.

Would you consider updating the alsa-oss.c program to become
truly OSS compatible?

The problems I have are with the functions

SNDCTL_DSP_SPEED
SNDCTL_DSP_CHANNELS

If you want to know a little more about my project, have a look at:
http://ham.te.hik.se/~sm5bsz/linuxdsp/linrad.htm
mirror at
http://nitehawk.com/sm5bsz/linuxdsp/linrad.htm


Kind regards

Leif =C5sbrink


--------------94CB04C2B374D043B8ED72B3--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
