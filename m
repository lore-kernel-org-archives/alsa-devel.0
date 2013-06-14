From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] ASoc: si476x: Do not use binary constants
Date: Fri, 14 Jun 2013 09:49:34 +0100
Message-ID: <1371199774-3946-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Andrey Smirnov <andrey.smirnov@convergeddevices.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gcc < 4.3 doesn't understand binary constants (0b*):

sound/soc/codecs/si476x.c:172:8: error: invalid suffix "b1111110" on integer constant
sound/soc/codecs/si476x.c:219:9: error: invalid suffix "b111" on integer constant
sound/soc/codecs/si476x.c:219:56: error: invalid suffix "b111" on integer constant

So use hexadecimal constants (0x*) instead.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Andrey Smirnov <andrey.smirnov@convergeddevices.net>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/si476x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 721587c..73e205c 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -38,9 +38,9 @@ enum si476x_digital_io_output_format {
 	SI476X_DIGITAL_IO_SAMPLE_SIZE_SHIFT	= 8,
 };
 
-#define SI476X_DIGITAL_IO_OUTPUT_WIDTH_MASK	((0b111 << SI476X_DIGITAL_IO_SLOT_SIZE_SHIFT) | \
-						  (0b111 << SI476X_DIGITAL_IO_SAMPLE_SIZE_SHIFT))
-#define SI476X_DIGITAL_IO_OUTPUT_FORMAT_MASK	(0b1111110)
+#define SI476X_DIGITAL_IO_OUTPUT_WIDTH_MASK	((0x7 << SI476X_DIGITAL_IO_SLOT_SIZE_SHIFT) | \
+						  (0x7 << SI476X_DIGITAL_IO_SAMPLE_SIZE_SHIFT))
+#define SI476X_DIGITAL_IO_OUTPUT_FORMAT_MASK	(0x7e)
 
 enum si476x_daudio_formats {
 	SI476X_DAUDIO_MODE_I2S		= (0x0 << 1),
-- 
1.8.1.2
