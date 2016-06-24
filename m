From: Colin King <colin.king@canonical.com>
Subject: [PATCH] SoC: dwc:  trivial fix of spelling mistake "unsuppted" -> "unsupported"
Date: Fri, 24 Jun 2016 18:14:53 +0100
Message-ID: <1466788493-17392-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jiri Kosina <trivial@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Yitian Bu <buyitian@gmail.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Jon Medhurst <tixy@linaro.org>, yitian <yitian.bu@tangramtek.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/dwc/designware_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 0db69b7..1223ba6 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -278,7 +278,7 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	default:
-		dev_err(dev->dev, "designware-i2s: unsuppted PCM fmt");
+		dev_err(dev->dev, "designware-i2s: unsupported PCM fmt");
 		return -EINVAL;
 	}
 
-- 
2.8.1
