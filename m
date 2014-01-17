From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 01/16] ALSA: Oxygen: Add the separate SPI
	waiting function
Date: Fri, 17 Jan 2014 19:08:20 +0400
Message-ID: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

This function performs waiting when the SPI bus completes
a transaction. Timeout error checking introduced and
the timeout increased to 400 from 40.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/oxygen_io.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 521eae4..a917f37 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -194,6 +194,21 @@ void oxygen_write_ac97_masked(struct oxygen *chip, unsigned int codec,
 }
 EXPORT_SYMBOL(oxygen_write_ac97_masked);
 
+static int oxygen_wait_spi(struct oxygen *chip)
+{
+	/* Higher timeout to be sure: 400 microseconds */
+	unsigned int count;
+	for (count = 100; count > 0; count--) {
+		if ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) &
+						OXYGEN_SPI_BUSY) == 0)
+			return 0;
+		udelay(4);
+		--count;
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
