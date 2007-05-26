From: "Ash Willis" <ashwillis@programmer.net>
Subject: [PATCH] Disable debugging output for the ALS300 driver
Date: Sat, 26 May 2007 13:26:35 +0000
Message-ID: <20070526132636.0972E87301@cal1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cal1-1.us4.outblaze.com (cal1-1.us4.outblaze.com
	[205.158.62.188])
	by alsa0.perex.cz (Postfix) with ESMTP id BA8AB243B8
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2007 15:26:43 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Disables debugging output in the ALS300 driver.
Also contains a whitespace cleanup and a fix for a potential bug.

Signed-off-by: Ash Willis <ashwillis@programmer.net>

----------------------------------------------------

diff -r 337962e19de6 -r 8ea4fa014563 pci/als300.c
--- a/pci/als300.c=A0=A0=A0 Fri May 25 12:18:49 2007 +0200
+++ b/pci/als300.c=A0=A0=A0 Sat May 26 14:04:14 2007 +0000
@@ -88,8 +88,8 @@
=A0#define PLAYBACK_BLOCK_COUNTER=A0=A0=A0 0x9A
=A0#define RECORD_BLOCK_COUNTER=A0=A0=A0 0x9B
=A0
-#define DEBUG_CALLS=A0=A0=A0 1
-#define DEBUG_PLAY_REC=A0=A0=A0 1
+#define DEBUG_CALLS=A0=A0=A0 0
+#define DEBUG_PLAY_REC=A0=A0=A0 0
=A0
=A0#if DEBUG_CALLS
=A0#define snd_als300_dbgcalls(format, args...) printk(format, ##args)
@@ -730,10 +730,9 @@ static int __devinit snd_als300_create(s
=A0=A0=A0=A0 }
=A0=A0=A0=A0 chip->irq =3D pci->irq;
=A0
-
=A0=A0=A0=A0 snd_als300_init(chip);
=A0
-=A0=A0=A0 if (snd_als300_ac97(chip) < 0) {
+=A0=A0=A0 if ((err =3D snd_als300_ac97(chip)) < 0) {
=A0=A0=A0=A0 =A0=A0=A0 snd_printk(KERN_WARNING "Could not create ac97\n");
=A0=A0=A0=A0 =A0=A0=A0 snd_als300_free(chip);
=A0=A0=A0=A0 =A0=A0=A0 return err;
