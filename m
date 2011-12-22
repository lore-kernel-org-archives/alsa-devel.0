From: linux@audioscience.com
Subject: [PATCH 14/21] Simplify dsp code close.
Date: Thu, 22 Dec 2011 13:38:44 +1300
Message-ID: <1324514331-22570-15-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 98F80103C2A
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:15 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:30 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
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

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

dsp_code struct is not created if firmware is invalid, so check
and zero of firmware pointer is not necessary

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpidspcd.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index 21cdb9e..456a758 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -109,11 +109,8 @@ error1:
 /*-------------------------------------------------------------------*/
 void hpi_dsp_code_close(struct dsp_code *dsp_code)
 {
-	if (dsp_code->pvt->firmware) {
-		HPI_DEBUG_LOG(DEBUG, "dsp code closed\n");
-		release_firmware(dsp_code->pvt->firmware);
-		dsp_code->pvt->firmware = NULL;
-	}
+	HPI_DEBUG_LOG(DEBUG, "dsp code closed\n");
+	release_firmware(dsp_code->pvt->firmware);
 	kfree(dsp_code->pvt);
 }
 
-- 
1.7.0.4
