From: linux@audioscience.com
Subject: [PATCH 12/21] Increase debug response buffer size.
Date: Thu, 22 Dec 2011 13:38:42 +1300
Message-ID: <1324514331-22570-13-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B00B103C2C
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:13 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:28 +1300 (NZDT)
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

Enables retrieving more debug info in fewer transactions.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi_internal.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 2a63308..4cc315d 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -1132,7 +1132,7 @@ struct hpi_res_adapter_get_info {
 
 struct hpi_res_adapter_debug_read {
 	struct hpi_response_header h;
-	u8 bytes[256];
+	u8 bytes[1024];
 };
 
 struct hpi_msg_cobranet_hmi {
-- 
1.7.0.4
