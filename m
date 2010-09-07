From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 3/4] ASoC: UDA1380: Add delay between power on
	and reset
Date: Tue,  7 Sep 2010 17:04:17 +0300
Message-ID: <1283868258-26493-4-git-send-email-anarsoul@gmail.com>
References: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EC94F2449F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:15:28 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2228960eyd.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 07:15:28 -0700 (PDT)
In-Reply-To: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Philipp Zabel <philipp.zabel@gmail.com>, anarsoul@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/uda1380.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 488f801..0c6c725 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -616,6 +616,7 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			if (gpio_is_valid(pdata->gpio_power)) {
 				gpio_set_value(pdata->gpio_power, 1);
+				mdelay(1);
 				uda1380_reset(codec);
 			}
 
-- 
1.7.2.2
