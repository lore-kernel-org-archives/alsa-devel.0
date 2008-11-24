From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/9] ASoC: TWL4030: Add helper function for mux
	handling.
Date: Mon, 24 Nov 2008 13:49:37 +0200
Message-ID: <1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C4952435D
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:49:53 +0100 (CET)
In-Reply-To: <1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Some of TWL4030's input selection are in bitfield, which
needs special helper function to deal with.
For example: PREDL_CTL register:
 bit 0 (0x1): voice_en
 bit 1 (0x2): Audio L1 enable (DACL1)
 bit 2 (0x4): Audio L2 enable (DACL2)
 bit 3 (0x8): Audio R2 enable (DACR2)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   51 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 91effd3..17f2b51 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -191,6 +191,57 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 }
 
 /*
+ * Some of TWL's input selection are in bitfield.
+ * Dealing with those need special function
+ * For example: PREDL_CTL register:
+ * bit 0 (0x1): voice_en
+ * bit 1 (0x2): Audio L1 enable (DACL1)
+ * bit 2 (0x4): Audio L2 enable (DACL2)
+ * bit 3 (0x8): Audio R2 enable (DACR2)
+ */
+static int snd_soc_get_enum_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int val_mask = 0;
+	int i;
+	int val = twl4030_read_reg_cache(codec, e->reg);
+
+	for (i = 0; i < e->max - 1; i++)
+		val_mask |= (1 << i);
+
+	val = (val >> e->shift_l) & val_mask;
+	i = 0;
+	while (val && i++ < e->max)
+		val >>= 1;
+
+	ucontrol->value.integer.value[0] = i;
+	return 0;
+}
+
+static int snd_soc_put_enum_twl4030(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int val_mask = 0;
+	int val = 0;
+	int i;
+
+	for (i = 0; i < e->max - 1; i++)
+		val_mask |= (1 << i);
+	val_mask <<= e->shift_l;
+
+	if (ucontrol->value.integer.value[0]) {
+		val = (1 << (ucontrol->value.integer.value[0] - 1));
+		val <<= e->shift_l;
+	}
+
+	return snd_soc_update_bits(codec, e->reg, val_mask, val);
+}
+
+/*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
  */
-- 
1.6.0.3
