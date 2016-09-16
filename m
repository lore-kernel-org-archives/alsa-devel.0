From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: max98926: add missing \n to end of dev_err/dev_dbg messages
Date: Fri, 16 Sep 2016 17:52:16 +0100
Message-ID: <20160916165216.12041-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, anish kumar <yesanishhere@gmail.com>, Axel Lin <axel.lin@ingics.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, some dev_err and deb_dbg messages are missing a \n, so
add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/max98926.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 5830a81..1eff7e0 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -347,7 +347,7 @@ static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		max98926_set_sense_data(max98926);
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(codec->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -364,7 +364,7 @@ static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		invert = MAX98926_DAI_BCI_MASK | MAX98926_DAI_WCI_MASK;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(codec->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -408,7 +408,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 		max98926->ch_size = 32;
 		break;
 	default:
-		dev_dbg(codec->dev, "format unsupported %d",
+		dev_dbg(codec->dev, "format unsupported %d\n",
 			params_format(params));
 		return -EINVAL;
 	}
-- 
2.9.3
