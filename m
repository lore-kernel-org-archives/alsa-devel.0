From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 2/4] ASoC: max98373: Added missing blank lines
Date: Tue,  9 Jan 2018 21:01:59 -0800
Message-ID: <1515560521-10850-2-git-send-email-ryans.lee@maximintegrated.com>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0110.outbound.protection.outlook.com [104.47.36.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E5262676B4
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 06:02:17 +0100 (CET)
In-Reply-To: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changelog:
	Added missing blank line into two places.

 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index e040b03..77b86c4 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -176,6 +176,7 @@ static int max98373_get_bclk_sel(int bclk)
 	}
 	return 0;
 }
+
 static int max98373_set_clock(struct snd_soc_codec *codec,
 	struct snd_pcm_hw_params *params)
 {
@@ -270,6 +271,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 			params_rate(params));
 		goto err;
 	}
+
 	/* set DAI_SR to correct LRCLK frequency */
 	regmap_update_bits(max98373->regmap,
 		MAX98373_R2027_PCM_SR_SETUP_1,
-- 
2.7.4
