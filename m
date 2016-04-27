From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH RESEND] ASoC: arizona: Do not create OUT4R widget for CS47L24/WM1831
Date: Wed, 27 Apr 2016 10:37:53 +0100
Message-ID: <1461749873-18373-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The CS47L24 and WM1831 codecs only use the OUT4L widget so we can
skip creation of the OUT4R widget.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index da61c62..0cd27e0 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -223,6 +223,8 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 
 	switch (arizona->type) {
 	case WM8997:
+	case CS47L24:
+	case WM1831:
 		break;
 	default:
 		ret = snd_soc_dapm_new_controls(dapm, &arizona_spkr, 1);
-- 
1.9.1
