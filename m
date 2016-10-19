From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RFC PATCH 2/2] ASoC: samsung: Print a one-time message if the snow driver's probe defers
Date: Wed, 19 Oct 2016 14:21:06 -0300
Message-ID: <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

If the snd_soc_register_card() fails due a missing resource and the probe
has to be deferred, the driver prints an error message.

But since many probe retries can happen before a resource is available,
the printed messages can spam the kernel log buffer and slow the boot.

The information is useful to know that a dependency was not meet and a
defer happened, but isn't necessary to print it on each probe deferral.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/soc/samsung/snow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index d8ac907bbb0d..068bfb78a668 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -103,7 +103,13 @@ static int snow_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		if (ret == -EPROBE_DEFER)
+			dev_err_once(&pdev->dev,
+				     "snd_soc_register_card deferred (%d)\n",
+				     ret);
+		else
+			dev_err(&pdev->dev,
+				"snd_soc_register_card failed (%d)\n", ret);
 		return ret;
 	}
 
-- 
2.7.4
