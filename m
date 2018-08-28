From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/7] ASoC: dapm: Don't fail creating new DAPM
	control on NULL pinctrl
Date: Tue, 28 Aug 2018 14:35:03 +0100
Message-ID: <20180828133508.13012-2-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A9252678BE
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

devm_pinctrl_get will only return NULL in the case that pinctrl
is not built into the kernel and all the pinctrl functions used
by the DAPM core are appropriately stubbed for that case. There
is no need to error out of snd_soc_dapm_new_control_unlocked
if pinctrl isn't built into the kernel, so change the
IS_ERR_OR_NULL to just an IS_ERR.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 78ab6965af55..d7be3981f026 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3487,7 +3487,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_pinctrl:
 		w->pinctrl = devm_pinctrl_get(dapm->dev);
-		if (IS_ERR_OR_NULL(w->pinctrl)) {
+		if (IS_ERR(w->pinctrl)) {
 			ret = PTR_ERR(w->pinctrl);
 			if (ret == -EPROBE_DEFER)
 				return ERR_PTR(ret);
-- 
2.11.0
