From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: rt5640: Staticize hp_amp_power_on
Date: Fri, 13 Sep 2013 15:22:18 +0530
Message-ID: <1379065938-26728-2-git-send-email-sachin.kamat@linaro.org>
References: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 39EB42608D1
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:10:32 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id y10so1048614pdj.36
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:10:31 -0700 (PDT)
In-Reply-To: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, bardliao@realtek.com, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

'hp_amp_power_on' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/rt5640.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index c26a8f8..2f6bb16 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -926,7 +926,7 @@ static int rt5640_set_dmic2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-void hp_amp_power_on(struct snd_soc_codec *codec)
+static void hp_amp_power_on(struct snd_soc_codec *codec)
 {
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
-- 
1.7.9.5
