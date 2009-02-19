From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Check for errors when writing WM8731
	reset register
Date: Thu, 19 Feb 2009 19:02:38 +0000
Message-ID: <1235070160-10709-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090219190140.GA9707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FD951037ED
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 20:02:48 +0100 (CET)
In-Reply-To: <20090219190140.GA9707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4191bdb..9c9fc3b 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -574,9 +574,14 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 
 	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
 
+	ret = wm8731_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
+	}
+
 	wm8731_dai.dev = codec->dev;
 
-	wm8731_reset(codec);
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-- 
1.5.6.3
