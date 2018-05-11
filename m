From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hisilicon: fix spelling mistake: "uknown" -> "unknown"
Date: Fri, 11 May 2018 14:28:18 +0100
Message-ID: <20180511132818.16728-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 07a57209e055..53344a3b7a60 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -498,7 +498,7 @@ static int hi6210_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			hi6210_i2s_txctrl(cpu_dai, 0);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "uknown cmd\n");
+		dev_err(cpu_dai->dev, "unknown cmd\n");
 		return -EINVAL;
 	}
 	return 0;
-- 
2.17.0
