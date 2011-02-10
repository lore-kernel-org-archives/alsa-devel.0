From: linux@audioscience.com
Subject: [PATCH 26/28] Tighten firmware version requirements.
Date: Thu, 10 Feb 2011 17:26:19 +1300
Message-ID: <1297311981-30448-27-git-send-email-linux@audioscience.com>
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

Difference in major.minor between driver and firmware is an error now.
Release version mismatch give a warning.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpidspcd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/pci/asihpi/hpidspcd.c b/pci/asihpi/hpidspcd.c
index f9958e9..fb311d8 100644
--- a/pci/asihpi/hpidspcd.c
+++ b/pci/asihpi/hpidspcd.c
@@ -100,9 +100,9 @@ short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
 		goto error2;
 	}
 
-	if (header.version / 10000 != HPI_VER_DECIMAL / 10000) {
+	if (header.version / 100 != HPI_VER_DECIMAL / 100) {
 		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
-			"Firmware Major Version mismatch "
+			"Incompatible firmware version "
 			"DSP image %d != Driver %d\n", header.version,
 			HPI_VER_DECIMAL);
 		goto error2;
@@ -110,9 +110,8 @@ short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
 
 	if (header.version != HPI_VER_DECIMAL) {
 		dev_printk(KERN_WARNING, &ps_dsp_code->ps_dev->dev,
-			"firmware: version mismatch  DSP image %d != Driver %d\n",
+			"Firmware: release version mismatch  DSP image %d != Driver %d\n",
 			header.version, HPI_VER_DECIMAL);
-		/* goto error2;  still allow driver to load */
 	}
 
 	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
-- 
1.7.0.4
