From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: max98090: Fix missing free_irq
Date: Thu, 19 Jun 2014 09:32:05 +0300
Message-ID: <1403159525-4352-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

max98090.c doesn't free the threaded interrupt it requests. This causes
an oops when doing "cat /proc/interrupts" after snd-soc-max98090.ko is
unloaded.

Fix this by requesting the interrupt by using devm_request_threaded_irq().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Stable <stable@vger.kernel.org> # 3.10+
---
This issue has been in max98090.c since v3.8 commit 685e42154dcf
("ASoC: Replace max98090 Device Driver"). However this patch applies only
after v3.10 which has 3d15aacbb802 ("ASoC: max98090: request IRQF_ONESHOT
interrupt").
I'm not sure is there need to go before that since first upstream max98090
user was introduced in a v3.14 commit 7637af2e17f1 ("ASoC: tegra:
add tegra+MAX98090 machine driver"). However I'm aware there is an
out-of-tree 3.10 user.
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f5fccc7a8e89..d97f1ce7ff7d 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2284,7 +2284,7 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	/* Register for interrupts */
 	dev_dbg(codec->dev, "irq = %d\n", max98090->irq);
 
-	ret = request_threaded_irq(max98090->irq, NULL,
+	ret = devm_request_threaded_irq(codec->dev, max98090->irq, NULL,
 		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 		"max98090_interrupt", codec);
 	if (ret < 0) {
-- 
2.0.0
