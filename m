From: linux@audioscience.com
Subject: [PATCH - ASIHPI 5/8] Log warning if DSP code version
 doesn't match driver.
Date: Thu, 05 Jun 2008 16:06:58 +1200
Message-ID: <1212638821-2779-5-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
	<1212638821-2779-3-git-send-email-linux@audioscience.com>
	<1212638821-2779-4-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id DE3451037EF
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:04 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:04 +1200 (NZST)
In-reply-to: <1212638821-2779-4-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <linux@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpidspcd.c b/pci/asihpi/hpidspcd.c
index 2665370..8c0f251 100644
--- a/pci/asihpi/hpidspcd.c
+++ b/pci/asihpi/hpidspcd.c
@@ -56,6 +56,9 @@ struct code_header {
 #pragma pack(pop)
 #endif
 
+#define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
+	    HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
+
 /***********************************************************************/
 #include "linux/pci.h"
 /*-------------------------------------------------------------------*/
@@ -100,6 +103,13 @@ short HpiDspCode_Open(
 		goto error2;
 	}
 
+	if (header.version != HPI_VER_DECIMAL) {
+		HPI_DEBUG_LOG(WARNING,
+			"Version mismatch  DSP image %d != Driver %d\n",
+			header.version, HPI_VER_DECIMAL);
+		/* goto error2;  still allow driver to load */
+	}
+
 	HPI_DEBUG_LOG(INFO, "Dsp code %s opened\n", fw_name);
 	psDspCode->psFirmware = psFirmware;
 	psDspCode->dwBlockLength = header.size / sizeof(u32);
-- 
1.5.4.3
