From: klem.dev@gmail.com
Subject: [PATCH 4/4] ESI W192M: Add text "Line in/Mic".
Date: Sat,  5 Oct 2013 15:41:05 +0200
Message-ID: <525016f4.a556b40a.02db.ffff9b76@mx.google.com>
References: <1380980465-5961-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1380980465-5961-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Clement Guedez <klem.dev@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Clement Guedez <klem.dev@gmail.com>

Add text "Line in/Mic" for selecting input gain state for Ego Sys Waveterminal 192M.

Signed-off-by: Clement Guedez <klem.dev@gmail.com>
---
 sound/pci/ice1712/wtm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index cf2b6a5..464cca5 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -377,8 +377,23 @@ static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
 /*
  * MIC / LINE switch fonction
  */
+static int stac9460_mic_sw_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2] = { "Line In", "Mic" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
 
-#define stac9460_mic_sw_info		snd_ctl_boolean_mono_info
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items
+		- 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
 
 static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
@@ -392,7 +407,7 @@ static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
 		val = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
 		val = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
-	ucontrol->value.integer.value[0] = ~val>>7 & 0x1;
+	ucontrol->value.enumerated.item[0] = (val >> 7) & 0x1;
 	return 0;
 }
 
@@ -408,7 +423,7 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 		old = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
 		old = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
-	new = (~ucontrol->value.integer.value[0] << 7 & 0x80) | (old & ~0x80);
+	new = (ucontrol->value.enumerated.item[0] << 7 & 0x80) | (old & ~0x80);
 	change = (new != old);
 	if (change) {
 		if (id == 0)
-- 
1.8.4.rc3
