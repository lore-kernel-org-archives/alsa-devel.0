From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"
Date: Thu,  7 Feb 2019 09:26:42 +0000
Message-ID: <20190207092642.6655-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the SOC_SINGLE control name. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..24b1b23b99c9 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -161,7 +161,7 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
-	SOC_SINGLE("Deemphatize Filter Playback Switch",
+	SOC_SINGLE("Deemphasize Filter Playback Switch",
 		   JZ4725B_CODEC_REG_CR2,
 		   REG_CR2_DAC_DEEMP_OFFSET, 1, 0),
 
-- 
2.20.1
