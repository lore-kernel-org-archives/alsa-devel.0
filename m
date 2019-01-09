From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: Intel: bytcht_es8316: Set correct platform drvdata in snd_byt_cht_es8316_mc_probe()
Date: Wed, 9 Jan 2019 08:36:51 +0000
Message-ID: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe() set
it to 'struct snd_soc_card', fix to pass correct platform drvdata to
platform_set_drvdata().

Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index cdf2061..42111d8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -538,7 +538,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
 		return ret;
 	}
-	platform_set_drvdata(pdev, &byt_cht_es8316_card);
+	platform_set_drvdata(pdev, priv);
 	return 0;
 }
