From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
Date: Wed, 03 Dec 2014 16:38:55 +0000
Message-ID: <547F3C9F.8080102@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 08f0229..f8946bd 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -280,7 +280,8 @@ static int dw_i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		dev->active--;
+		if (dev->active > 0)
+			dev->active--;
 		i2s_stop(dev, substream);
 		break;
 	default:
-- 
1.7.1
