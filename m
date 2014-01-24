From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 02/19] ALSA: Oxygen: Modify the SPI writing
	function
Date: Fri, 24 Jan 2014 16:18:03 +0400
Message-ID: <1390565900-3337-2-git-send-email-v1ron@mail.ru>
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

Modify the oxygen_write_spi() function to use the newly
introduced oxygen_wait_spi() function. Change return value
from void to int, so it can return error codes. Older
drivers just ignore that return value, new drivers can
check this value. We need to wait AFTER
initiating the SPI transaction, otherwise read
operation will not work.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/oxygen.h    |    2 +-
 sound/pci/oxygen/oxygen_io.c |   15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/pci/oxygen/oxygen.h b/sound/pci/oxygen/oxygen.h
index 09a24b2..c10ab07 100644
--- a/sound/pci/oxygen/oxygen.h
+++ b/sound/pci/oxygen/oxygen.h
@@ -198,7 +198,7 @@ void oxygen_write_ac97(struct oxygen *chip, unsigned int codec,
 void oxygen_write_ac97_masked(struct oxygen *chip, unsigned int codec,
 			      unsigned int index, u16 data, u16 mask);
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
+int oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data);
 void oxygen_write_i2c(struct oxygen *chip, u8 device, u8 map, u8 data);
 
 void oxygen_reset_uart(struct oxygen *chip);
diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 471e64a..04f529e 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -209,23 +209,16 @@ static int oxygen_wait_spi(struct oxygen *chip)
 	return -EIO;
 }
 
-void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
+int oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
 {
-	unsigned int count;
-
-	/* should not need more than 30.72 us (24 * 1.28 us) */
-	count = 10;
-	while ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) & OXYGEN_SPI_BUSY)
-	       && count > 0) {
-		udelay(4);
-		--count;
-	}
-
+	/* We need to wait AFTER initiating the SPI transaction,
+	   otherwise read operations will not work */
 	oxygen_write8(chip, OXYGEN_SPI_DATA1, data);
 	oxygen_write8(chip, OXYGEN_SPI_DATA2, data >> 8);
 	if (control & OXYGEN_SPI_DATA_LENGTH_3)
 		oxygen_write8(chip, OXYGEN_SPI_DATA3, data >> 16);
 	oxygen_write8(chip, OXYGEN_SPI_CONTROL, control);
+	return oxygen_wait_spi(chip);
 }
 EXPORT_SYMBOL(oxygen_write_spi);
 
-- 
1.7.10.4
