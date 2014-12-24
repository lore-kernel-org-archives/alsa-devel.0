From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: rt5677: fixed rt5677_dsp_vad_put
	rt5677_dsp_vad_get panic
Date: Tue, 23 Dec 2014 23:49:05 -0400
Message-ID: <1419392945-29971-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6507F260882
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 08:50:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, kevin.strasser@intel.com, denny.iriawan@intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

snd_kcontrol_chip should return snd_soc_component instead of
snd_soc_codec

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5677.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 81fe146..c0fbe18 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -784,8 +784,8 @@ static unsigned int bst_tlv[] = {
 static int rt5677_dsp_vad_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = rt5677->dsp_vad_en;
 
@@ -795,8 +795,9 @@ static int rt5677_dsp_vad_get(struct snd_kcontrol *kcontrol,
 static int rt5677_dsp_vad_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
 	rt5677->dsp_vad_en = !!ucontrol->value.integer.value[0];
 
-- 
1.7.9.5
