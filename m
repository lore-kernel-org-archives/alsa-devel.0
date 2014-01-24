From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 01/19] ALSA: Oxygen: Add the separate SPI
	waiting function
Date: Fri, 24 Jan 2014 16:18:02 +0400
Message-ID: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

The oxygen_wait_spi() function now performs waiting when the
SPI bus completes a transaction. Introduce the timeout error
checking and increase timeout to 200 from 40.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/oxygen_io.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 521eae4..471e64a 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -194,6 +194,21 @@ void oxygen_write_ac97_masked(struct oxygen *chip, unsigned int codec,
 }
 EXPORT_SYMBOL(oxygen_write_ac97_masked);
 
+static int oxygen_wait_spi(struct oxygen *chip)
+{
+	/* Higher timeout to be sure: 200 us,
+	   Actual transaction should not need more than 40 us */
+	unsigned int count;
+	for (count = 50; count > 0; count--) {
+		udelay(4);
+		if ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) &
+						OXYGEN_SPI_BUSY) == 0)
+			return 0;
+	}
+	snd_printk(KERN_ERR "Oxygen: SPI wait timeout\n");
+	return -EIO;
+}
+
 void oxygen_write_spi(struct oxygen *chip, u8 control, unsigned int data)
 {
 	unsigned int count;
-- 
1.7.10.4
