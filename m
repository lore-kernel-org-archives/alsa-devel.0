From: =?UTF-8?B?UmljaGFyZCBLw7ZyYmVy?= <alsa@ml.shredzone.de>
Subject: Re: [PATCH] USB-audio: Sound Blaster HD iec958 is on
 device 1
Date: Wed, 21 Jan 2015 22:57:54 +0100
Message-ID: <54C020E2.2080402@ml.shredzone.de>
References: <5341C8DF.9020604@ml.shredzone.de>	<s5hk3b1ms1f.wl%tiwai@suse.de>	<54BEEC9A.8070805@ml.shredzone.de>
 <s5hmw5bvr0a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040509050605030606030800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arrietty.shredzone.net (arrietty.shredzone.net
 [213.133.102.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 922CD260447
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 22:57:55 +0100 (CET)
Received: from xdsl-87-79-250-88.netcologne.de ([87.79.250.88] helo=ronja.home)
 by arrietty.shredzone.net with esmtpsa (UNKNOWN:AES128-SHA:128)
 (Exim 4.72) (envelope-from <alsa@ml.shredzone.de>)
 id 1YE3He-0007Tm-Sq
 for alsa-devel@alsa-project.org; Wed, 21 Jan 2015 22:57:55 +0100
In-Reply-To: <s5hmw5bvr0a.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040509050605030606030800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> The patch can't be applied cleanly due to the space breakage likely by
> your MUA.  Please fix the setup or use an attachment.
>=20
> Also, don't forget your sign-off.


I'm sorry for the mistakes. It's my first time providing a git patch by m=
ail.

You'll find the signed-off patch file attached.

--=20
Richard K=C3=B6rber

--------------040509050605030606030800
Content-Type: text/x-patch;
 name="usb-soundblaster-hd.patch"
Content-Disposition: attachment;
 filename="usb-soundblaster-hd.patch"
Content-Transfer-Encoding: quoted-printable

>From b4e51c2ef6e8226021964465714c99c5a735ce3a Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Richard=3D20K=3DC3=3DB6rber?=3D <dev@shredzone.de>
Date: Wed, 21 Jan 2015 22:50:27 +0100
Subject: [PATCH] USB-audio: Sound Blaster HD iec958 is on device 1
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Creative Sound Blaster X-Fi HD uses device 1 for iec958 output.

Signed-off-by: Richard K=C3=B6rber <dev@shredzone.de>
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.con=
f
index 05e5d09..bae7669 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -36,6 +36,7 @@ USB-Audio.pcm.surround40_type {
 # number for the iec958 device can be changed here.
 USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
+        "USB Sound Blaster HD" 1
=20
 	# The below don't have digital in/out, so prevent them from being opene=
d.
 	"Andrea PureAudio USB-SA Headset" 999
--=20
2.1.0


--------------040509050605030606030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040509050605030606030800--
