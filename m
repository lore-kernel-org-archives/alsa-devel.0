From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 003b/003] snd-powermac: style burgundy.c
Date: Wed, 16 Apr 2008 10:03:31 +0300
Message-ID: <46e1c7760804160003q80ecf23r74af7fdcddc8eee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id B7E0A10383E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 09:03:31 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so662269ana.80
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 00:03:31 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Coding style corrections for burgundy.c.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/burgundy.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/burgundy.c	2008-04-07 12:00:20.893307568 +0300
@@ -102,7 +102,8 @@ snd_pmac_burgundy_rcw(struct snd_pmac *c
 }

 static void
-snd_pmac_burgundy_wcb(struct snd_pmac *chip, unsigned int addr,
unsigned int val)
+snd_pmac_burgundy_wcb(struct snd_pmac *chip, unsigned int addr,
+		      unsigned int val)
 {
 	out_le32(&chip->awacs->codec_ctrl, addr + 0x300000 + (val & 0xff));
 	snd_pmac_burgundy_busy_wait(chip);
@@ -126,8 +127,11 @@ snd_pmac_burgundy_rcb(struct snd_pmac *c
 	return val;
 }

+#define BASE2ADDR(base)	((base) << 12)
+#define ADDR2BASE(addr)	((addr) >> 12)
+
 /*
- * Burgundy volume: 0 - 100, stereo
+ * Burgundy volume: 0 - 100, stereo, word reg
  */
 static void
 snd_pmac_burgundy_write_volume(struct snd_pmac *chip, unsigned int address,
@@ -168,13 +172,6 @@ snd_pmac_burgundy_read_volume(struct snd
 		volume[1] = 0;
 }

-
-/*
- */
-
-#define BASE2ADDR(base)	((base) << 12)
-#define ADDR2BASE(addr)	((addr) >> 12)
-
 static int snd_pmac_burgundy_info_volume(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_info *uinfo)
 {
@@ -191,8 +188,8 @@ static int snd_pmac_burgundy_get_volume(
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
 	int shift = (kcontrol->private_value >> 8) & 0xff;
-	snd_pmac_burgundy_read_volume(chip, addr, ucontrol->value.integer.value,
-				      shift);
+	snd_pmac_burgundy_read_volume(chip, addr,
+				      ucontrol->value.integer.value, shift);
 	return 0;
 }

@@ -204,8 +201,8 @@ static int snd_pmac_burgundy_put_volume(
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	long nvoices[2];

-	snd_pmac_burgundy_write_volume(chip, addr, ucontrol->value.integer.value,
-				       shift);
+	snd_pmac_burgundy_write_volume(chip, addr,
+				       ucontrol->value.integer.value, shift);
 	snd_pmac_burgundy_read_volume(chip, addr, nvoices, shift);
 	return (nvoices[0] != ucontrol->value.integer.value[0] ||
 		nvoices[1] != ucontrol->value.integer.value[1]);
