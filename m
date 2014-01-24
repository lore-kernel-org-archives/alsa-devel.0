From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 07/19] ALSA: Oxygen: Add new CS4245 SPI
	functions
Date: Fri, 24 Jan 2014 16:18:08 +0400
Message-ID: <1390565900-3337-7-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

Add the new SPI write and read functions. The SPI read function
is used for creating initial registers dump and may be used for
debugging purposes. SPI operations are cached, so there is a new
function to manage the cache (shadow). I have to remove
the shift from the CS4245_SPI_* constants, since when
we are performing the reading, we need to shift by 8 instead
of 16.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/cs4245.h   |    7 +++--
 sound/pci/oxygen/xonar_dg.c |   64 +++++++++++++++++++++++++++++++++++++++++--
 sound/pci/oxygen/xonar_dg.h |    7 +++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/sound/pci/oxygen/cs4245.h b/sound/pci/oxygen/cs4245.h
index 5e0197e..9909865 100644
--- a/sound/pci/oxygen/cs4245.h
+++ b/sound/pci/oxygen/cs4245.h
@@ -102,6 +102,9 @@
 #define CS4245_ADC_OVFL		0x02
 #define CS4245_ADC_UNDRFL	0x01
 
+#define CS4245_SPI_ADDRESS_S	(0x9e << 16)
+#define CS4245_SPI_WRITE_S	(0 << 16)
 
-#define CS4245_SPI_ADDRESS	(0x9e << 16)
-#define CS4245_SPI_WRITE	(0 << 16)
+#define CS4245_SPI_ADDRESS	0x9e
+#define CS4245_SPI_WRITE	0
+#define CS4245_SPI_READ		1
diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 2a0ad6e..28cfeeb 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -64,6 +64,66 @@
 #include "xonar_dg.h"
 #include "cs4245.h"
 
+int cs4245_write_spi(struct oxygen *chip, u8 reg)
+{
+	struct dg *data = chip->model_data;
+	register unsigned int packet;
+
+	packet = (u32)reg;
+	packet <<= 8;
+	packet |= (CS4245_SPI_ADDRESS | CS4245_SPI_WRITE) << 16;
+	packet |= data->cs4245_shadow[reg];
+
+	return oxygen_write_spi(chip, OXYGEN_SPI_TRIGGER |
+			 OXYGEN_SPI_DATA_LENGTH_3 |
+			 OXYGEN_SPI_CLOCK_1280 |
+			 (0 << OXYGEN_SPI_CODEC_SHIFT) |
+			 OXYGEN_SPI_CEN_LATCH_CLOCK_HI,
+			 packet);
+}
+
+int cs4245_read_spi(struct oxygen *chip, u8 addr)
+{
+	struct dg *data = chip->model_data;
+	int ret;
+
+	ret = oxygen_write_spi(chip, OXYGEN_SPI_TRIGGER |
+		OXYGEN_SPI_DATA_LENGTH_2 |
+		OXYGEN_SPI_CEN_LATCH_CLOCK_HI |
+		OXYGEN_SPI_CLOCK_1280 | (0 << OXYGEN_SPI_CODEC_SHIFT),
+		((CS4245_SPI_ADDRESS | CS4245_SPI_WRITE) << 8) | addr);
+	if (ret < 0)
+		return ret;
+
+	ret = oxygen_write_spi(chip, OXYGEN_SPI_TRIGGER |
+		OXYGEN_SPI_DATA_LENGTH_2 |
+		OXYGEN_SPI_CEN_LATCH_CLOCK_HI |
+		OXYGEN_SPI_CLOCK_1280 | (0 << OXYGEN_SPI_CODEC_SHIFT),
+		(CS4245_SPI_ADDRESS | CS4245_SPI_READ) << 8);
+	if (ret < 0)
+		return ret;
+
+	data->cs4245_shadow[addr] = oxygen_read8(chip, OXYGEN_SPI_DATA1);
+
+	return 0;
+}
+
+int cs4245_shadow_control(struct oxygen *chip, enum cs4245_shadow_operation op)
+{
+	struct dg *data = chip->model_data;
+	unsigned char addr;
+	int ret;
+
+	for (addr = 1; addr < ARRAY_SIZE(data->cs4245_shadow); addr++) {
+		ret = (op == CS4245_SAVE_TO_SHADOW ?
+			cs4245_read_spi(chip, addr) :
+			cs4245_write_spi(chip, addr));
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 static void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value)
 {
 	struct dg *data = chip->model_data;
@@ -73,8 +133,8 @@ static void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value)
 			 OXYGEN_SPI_CLOCK_1280 |
 			 (0 << OXYGEN_SPI_CODEC_SHIFT) |
 			 OXYGEN_SPI_CEN_LATCH_CLOCK_HI,
-			 CS4245_SPI_ADDRESS |
-			 CS4245_SPI_WRITE |
+			 CS4245_SPI_ADDRESS_S |
+			 CS4245_SPI_WRITE_S |
 			 (reg << 8) | value);
 	data->cs4245_regs[reg] = value;
 }
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 0812692..f861a4c 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -18,7 +18,14 @@
 #define PLAYBACK_DST_HP_FP	1
 #define PLAYBACK_DST_MULTICH	2
 
+enum cs4245_shadow_operation {
+	CS4245_SAVE_TO_SHADOW,
+	CS4245_LOAD_FROM_SHADOW
+};
+
 struct dg {
+	/* The shadow copy of the CS4245 register space */
+	unsigned char cs4245_shadow[17];
 	unsigned int output_sel;
 	s8 input_vol[4][2];
 	unsigned int input_sel;
-- 
1.7.10.4
