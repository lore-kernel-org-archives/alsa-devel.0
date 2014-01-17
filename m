From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 08/16] ALSA: Oxygen: Add new CS4245 SPI
	functions
Date: Fri, 17 Jan 2014 19:08:27 +0400
Message-ID: <1389971315-3215-8-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

The existing write function slightly changed. The new
read function added. This read function used for creating
initial registers dump and may be used for debugging
purposes. SPI operations are cached, so there is a new
function to work with the cache (shadow).

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   60 +++++++++++++++++++++++++++++++++++++++++++
 sound/pci/oxygen/xonar_dg.h |    7 +++++
 2 files changed, 67 insertions(+)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 2a0ad6e..0a8ebe1 100644
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
+	unsigned char addr;
+	int ret;
+
+	for (addr = 1; addr < ARRAY_SIZE((((struct dg *)0)->cs4245_shadow));
+								addr++) {
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
