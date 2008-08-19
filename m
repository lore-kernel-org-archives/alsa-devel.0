From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opl3sa2: replace nd_opl3sa2_info_xxx() with
 snd_wss_info_xxx()
Date: Tue, 19 Aug 2008 21:51:49 +0200
Message-ID: <20080819215149.ee9ff50e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id D5B9A2414F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Aug 2008 21:45:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Replace snd_opl3sa2_info_xxx() with snd_wss_info_xxx().
Drop check of card->private_data which cannot be NULL
if card is not NULL (spotted by Rene Herman).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/sound/isa/opl3sa2.c linux-2.6/sound/isa/opl3sa2.c
--- linux-ref/sound/isa/opl3sa2.c	2008-08-20 21:19:04.000000000 +0200
+++ linux-2.6/sound/isa/opl3sa2.c	2008-08-20 21:19:29.000000000 +0200
@@ -300,7 +300,7 @@ static irqreturn_t snd_opl3sa2_interrupt
 	struct snd_opl3sa2 *chip;
 	int handled = 0;
 
-	if (card == NULL || card->private_data == NULL)
+	if (card == NULL)
 		return IRQ_NONE;
 
 	chip = card->private_data;
@@ -338,29 +338,18 @@ static irqreturn_t snd_opl3sa2_interrupt
 
 #define OPL3SA2_SINGLE(xname, xindex, reg, shift, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_opl3sa2_info_single, \
+  .info = snd_wss_info_single, \
   .get = snd_opl3sa2_get_single, .put = snd_opl3sa2_put_single, \
   .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
 #define OPL3SA2_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
   .name = xname, .index = xindex, \
-  .info = snd_opl3sa2_info_single, \
+  .info = snd_wss_info_single, \
   .get = snd_opl3sa2_get_single, .put = snd_opl3sa2_put_single, \
   .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
   .tlv = { .p = (xtlv) } }
 
-static int snd_opl3sa2_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	int mask = (kcontrol->private_value >> 16) & 0xff;
-
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
-	return 0;
-}
-
 static int snd_opl3sa2_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_opl3sa2 *chip = snd_kcontrol_chip(kcontrol);
@@ -404,29 +393,18 @@ static int snd_opl3sa2_put_single(struct
 
 #define OPL3SA2_DOUBLE(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_opl3sa2_info_double, \
+  .info = snd_wss_info_double, \
   .get = snd_opl3sa2_get_double, .put = snd_opl3sa2_put_double, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
 #define OPL3SA2_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
   .name = xname, .index = xindex, \
-  .info = snd_opl3sa2_info_double, \
+  .info = snd_wss_info_double, \
   .get = snd_opl3sa2_get_double, .put = snd_opl3sa2_put_double, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22), \
   .tlv = { .p = (xtlv) } }
 
-static int snd_opl3sa2_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	int mask = (kcontrol->private_value >> 24) & 0xff;
-
-	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask;
-	return 0;
-}
-
 static int snd_opl3sa2_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_opl3sa2 *chip = snd_kcontrol_chip(kcontrol);

---------------------------------------------------------------------- 
Igrzyska na Dzikim Zachodzie!
Sprawdz >> http://link.interia.pl/f1edc 
	
