From: eliot@blennerhassett.gen.nz
Subject: [PATCH 09/10] ALSA: asihpi: don't fail probe if
	adapter mode read fails
Date: Thu, 20 Nov 2014 16:22:56 +1300
Message-ID: <1416453777-7155-10-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 46058265873
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:43 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB00KHUITVLJ50@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:42 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Only determining if low latency mode is enabled. Failure
indicates adapter has no modes

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpioctl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 9454932..e457eb8 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -424,14 +424,13 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	hm.adapter_index = adapter.adapter->index;
 	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
-	if (hr.error) {
-		HPI_DEBUG_LOG(ERROR,
-			"HPI_ADAPTER_GET_MODE failed, aborting\n");
-		goto err;
-	}
-
-	if (hr.u.ax.mode.adapter_mode == HPI_ADAPTER_MODE_LOW_LATENCY)
+	if (!hr.error
+		&& hr.u.ax.mode.adapter_mode == HPI_ADAPTER_MODE_LOW_LATENCY)
 		low_latency_mode = 1;
+	else
+		dev_info(&pci_dev->dev,
+			"Adapter at index %d is not in low latency mode\n",
+			adapter.adapter->index);
 
 	/* Check if IRQs are supported */
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
-- 
1.9.1
