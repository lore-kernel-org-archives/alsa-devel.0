From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: sigmadsp: Refuse to load firmware files with a non-supported version
Date: Wed, 19 Nov 2014 18:29:02 +0100
Message-ID: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Make sure to check the version field of the firmware header to make sure to
not accidentally try to parse a firmware file with a different layout.
Trying to do so can result in loading invalid firmware code to the device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/sigmadsp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index f2de7e0..81a38dd 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -159,6 +159,13 @@ int _process_sigma_firmware(struct device *dev,
 		goto done;
 	}
 
+	if (ssfw_head->version != 1) {
+		dev_err(dev,
+			"Failed to load firmware: Invalid version %d. Supported firmware versions: 1\n",
+			ssfw_head->version);
+		goto done;
+	}
+
 	crc = crc32(0, fw->data + sizeof(*ssfw_head),
 			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
-- 
1.8.0
