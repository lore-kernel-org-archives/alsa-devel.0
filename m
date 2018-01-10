From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 3/4] ASoC: max98373: Added TDM off if parameters are all zeroes
Date: Tue,  9 Jan 2018 21:02:00 -0800
Message-ID: <1515560521-10850-3-git-send-email-ryans.lee@maximintegrated.com>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changelog:
	Added tdm_mode off condition when all input parameters are zero

 sound/soc/codecs/max98373.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 77b86c4..c5ff30f 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -311,7 +311,10 @@ static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int mask;
 	int x, slot_found;
 
-	max98373->tdm_mode = true;
+	if (!tx_mask && !rx_mask && !slots && !slot_width)
+		max98373->tdm_mode = false;
+	else
+		max98373->tdm_mode = true;
 
 	/* BCLK configuration */
 	bsel = max98373_get_bclk_sel(slots * slot_width);
-- 
2.7.4
