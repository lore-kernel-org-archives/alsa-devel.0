From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/12] ak4642: fix a memory leak if failed to initialise
	AK4642
Date: Thu, 15 Jul 2010 10:52:09 +0800
Message-ID: <1279162329.29294.6.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ak4642 should be kfreed if ak4642_init() return error.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4642.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 7528a54..4feefa8 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -491,8 +491,10 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 
 	ret = ak4642_init(ak4642);
-	if (ret < 0)
+	if (ret < 0) {
 		printk(KERN_ERR "failed to initialise AK4642\n");
+		kfree(ak4642);
+	}
 
 	return ret;
 }
-- 
1.5.4.3
