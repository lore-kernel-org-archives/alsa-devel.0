From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: add MODULE_DEVICE_TABLE
Date: Fri, 04 Mar 2011 15:18:18 +0800
Message-ID: <1299223098.20907.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The device table is required to load modules based on modaliases.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320dac33.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 71d7be8..00b6d87 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1615,6 +1615,7 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
 
 static struct i2c_driver tlv320dac33_i2c_driver = {
 	.driver = {
-- 
1.7.2
