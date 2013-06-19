From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: wm8994: Use SOC_SINGLE_EXT()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:33:59 +0200
Message-ID: <1371663243-10032-7-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id ACAB5261B2E
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:34:02 +0200 (CEST)
In-Reply-To: <1371663243-10032-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8994.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 25580b5..1d4b1ec 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -290,10 +290,8 @@ static const DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(mixin_boost_tlv, 0, 900, 0);
 
 #define WM8994_DRC_SWITCH(xname, reg, shift) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
-	.put = wm8994_put_drc_sw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, 1, 0) }
+	SOC_SINGLE_EXT(xname, reg, shift, 1, 0, \
+		snd_soc_get_volsw, wm8994_put_drc_sw)
 
 static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
@@ -1433,10 +1431,8 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
 };
 
 #define WM8994_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = wm8994_put_class_w, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
+		snd_soc_get_volsw, wm8994_put_class_w)
 
 static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
-- 
1.8.0
