From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: wm8741: Make function 'wm8741_mute' static
Date: Sat, 16 Feb 2019 01:35:56 +0000
Message-ID: <20190216013556.117839-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sergej Sawazki <sergej@taudac.com>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warning:

sound/soc/codecs/wm8741.c:371:5: warning:
 symbol 'wm8741_mute' was not declared. Should it be static?

Fixes: 36b1599340b5 ("ASoC: wm8741: Add digital mute callback")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/wm8741.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index a4b8c459ea57..546ea735f534 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -368,7 +368,7 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
+static int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_component *component = codec_dai->component;
