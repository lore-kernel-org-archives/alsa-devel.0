From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/12] ad1836: fix a memory leak if another ad1836 is
	registered
Date: Thu, 15 Jul 2010 10:50:37 +0800
Message-ID: <1279162237.29294.4.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Barry Song <Barry.Song@analog.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ad1836 is allocated in ad1836_spi_probe() but is not freed if ad1836_register()
return -EINVAL (if another ad1836 is registered).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ad1836.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 2175384..a01006c 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -272,6 +272,7 @@ static int ad1836_register(struct ad1836_priv *ad1836)
 
 	if (ad1836_codec) {
 		dev_err(codec->dev, "Another ad1836 is registered\n");
+		kfree(ad1836);
 		return -EINVAL;
 	}
 
-- 
1.5.4.3
