From: linux@audioscience.com
Subject: [PATCH 01/28] Switch to dev_printk.
Date: Thu, 10 Feb 2011 17:25:54 +1300
Message-ID: <1297311981-30448-2-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpidspcd.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/pci/asihpi/hpidspcd.c b/pci/asihpi/hpidspcd.c
index 9b10d9a..f9958e9 100644
--- a/pci/asihpi/hpidspcd.c
+++ b/pci/asihpi/hpidspcd.c
@@ -71,47 +71,51 @@ short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
 	int err;
 
 	sprintf(fw_name, "asihpi/dsp%04x.bin", adapter);
-	HPI_DEBUG_LOG(INFO, "requesting firmware for %s\n", fw_name);
 
 	err = request_firmware(&ps_firmware, fw_name,
 		&ps_dsp_code->ps_dev->dev);
+
 	if (err != 0) {
-		HPI_DEBUG_LOG(ERROR, "%d, request_firmware failed for  %s\n",
-			err, fw_name);
+		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+			"%d, request_firmware failed for  %s\n", err,
+			fw_name);
 		goto error1;
 	}
 	if (ps_firmware->size < sizeof(header)) {
-		HPI_DEBUG_LOG(ERROR, "header size too small %s\n", fw_name);
+		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+			"Header size too small %s\n", fw_name);
 		goto error2;
 	}
 	memcpy(&header, ps_firmware->data, sizeof(header));
 	if (header.adapter != adapter) {
-		HPI_DEBUG_LOG(ERROR, "adapter type incorrect %4x != %4x\n",
-			header.adapter, adapter);
+		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+			"Adapter type incorrect %4x != %4x\n", header.adapter,
+			adapter);
 		goto error2;
 	}
 	if (header.size != ps_firmware->size) {
-		HPI_DEBUG_LOG(ERROR, "code size wrong  %d != %ld\n",
-			header.size, (unsigned long)ps_firmware->size);
+		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+			"Code size wrong  %d != %ld\n", header.size,
+			(unsigned long)ps_firmware->size);
 		goto error2;
 	}
 
 	if (header.version / 10000 != HPI_VER_DECIMAL / 10000) {
-		HPI_DEBUG_LOG(ERROR,
-			"firmware major version mismatch "
-			"DSP image %d != driver %d\n", header.version,
+		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+			"Firmware Major Version mismatch "
+			"DSP image %d != Driver %d\n", header.version,
 			HPI_VER_DECIMAL);
 		goto error2;
 	}
 
 	if (header.version != HPI_VER_DECIMAL) {
-		HPI_DEBUG_LOG(WARNING,
-			"version mismatch  DSP image %d != driver %d\n",
+		dev_printk(KERN_WARNING, &ps_dsp_code->ps_dev->dev,
+			"firmware: version mismatch  DSP image %d != Driver %d\n",
 			header.version, HPI_VER_DECIMAL);
 		/* goto error2;  still allow driver to load */
 	}
 
-	HPI_DEBUG_LOG(INFO, "dsp code %s opened\n", fw_name);
+	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
 	ps_dsp_code->ps_firmware = ps_firmware;
 	ps_dsp_code->block_length = header.size / sizeof(u32);
 	ps_dsp_code->word_count = sizeof(header) / sizeof(u32);
@@ -148,7 +152,7 @@ void hpi_dsp_code_rewind(struct dsp_code *ps_dsp_code)
 short hpi_dsp_code_read_word(struct dsp_code *ps_dsp_code, u32 *pword)
 {
 	if (ps_dsp_code->word_count + 1 > ps_dsp_code->block_length)
-		return (HPI_ERROR_DSP_FILE_FORMAT);
+		return HPI_ERROR_DSP_FILE_FORMAT;
 
 	*pword = ((u32 *)(ps_dsp_code->ps_firmware->data))[ps_dsp_code->
 		word_count];
-- 
1.7.0.4
