From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 1/3] ALSA: hda - Add 4 channel mode for
	3stack-hp model (ALC888)
Date: Wed,  4 Mar 2009 14:22:50 -0300
Message-ID: <1236187372-15818-1-git-send-email-herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 902B4103826
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 18:28:45 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Add additional 4 channel mode for 3stack-hp models.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c02f78..3696ff3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8068,24 +8068,45 @@ static struct hda_verb alc888_6st_dell_verbs[] = {
 	{ }
 };
 
+/*
+ * 2ch mode
+ */
 static struct hda_verb alc888_3st_hp_2ch_init[] = {
 	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
 	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
 	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
 	{ 0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
-	{ }
+	{ } /* end */
 };
 
+/*
+ * 4ch mode
+ */
+static struct hda_verb alc888_3st_hp_4ch_init[] = {
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x16, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ } /* end */
+};
+
+/*
+ * 6ch mode
+ */
 static struct hda_verb alc888_3st_hp_6ch_init[] = {
 	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
 	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x18, AC_VERB_SET_CONNECT_SEL, 0x02 },
 	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
 	{ 0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ }
+	{ 0x16, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ } /* end */
 };
 
-static struct hda_channel_mode alc888_3st_hp_modes[2] = {
+static struct hda_channel_mode alc888_3st_hp_modes[3] = {
 	{ 2, alc888_3st_hp_2ch_init },
+	{ 4, alc888_3st_hp_4ch_init },
 	{ 6, alc888_3st_hp_6ch_init },
 };
 
-- 
1.6.1.3
