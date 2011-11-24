From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: SigmaDSP: Provide diagnostic error messages
Date: Thu, 24 Nov 2011 13:48:25 +0100
Message-ID: <1322138908-32127-6-git-send-email-lars@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Provide some error messages when loading the firmware fails, so it is possible
to diagnose the reason for the failure.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 01b69f4..e13501a 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -118,18 +118,26 @@ int process_sigma_firmware(struct i2c_client *client, const char *name)
 	 * chosen a bit arbitrarily but it should be enough for all practical
 	 * purposes and having the limit makes it easier to avoid integer
 	 * overflows later in the loading process. */
-	if (fw->size < sizeof(*ssfw_head) || fw->size >= 0x4000000)
+	if (fw->size < sizeof(*ssfw_head) || fw->size >= 0x4000000) {
+		dev_err(&client->dev, "Failed to load firmware: Invalid size\n");
 		goto done;
+	}
 
 	ssfw_head = (void *)fw->data;
-	if (memcmp(ssfw_head->magic, SIGMA_MAGIC, ARRAY_SIZE(ssfw_head->magic)))
+	if (memcmp(ssfw_head->magic, SIGMA_MAGIC, ARRAY_SIZE(ssfw_head->magic))) {
+		dev_err(&client->dev, "Failed to load firmware: Invalid magic\n");
 		goto done;
+	}
 
 	crc = crc32(0, fw->data + sizeof(*ssfw_head),
 			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
-	if (crc != le32_to_cpu(ssfw_head->crc))
+	if (crc != le32_to_cpu(ssfw_head->crc)) {
+		dev_err(&client->dev, "Failed to load firmware: Wrong crc checksum:" \
+			" expected %x got %x.\n",
+			le32_to_cpu(ssfw_head->crc), crc);
 		goto done;
+	}
 
 	ssfw.pos = sizeof(*ssfw_head);
 
-- 
1.7.7.1
