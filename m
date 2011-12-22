From: linux@audioscience.com
Subject: [PATCH 11/21] Add new function codes.
Date: Thu, 22 Dec 2011 13:38:41 +1300
Message-ID: <1324514331-22570-12-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ED6A103C23
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:12 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:27 +1300 (NZDT)
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

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi_internal.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index e06c5e0..2a63308 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -240,7 +240,9 @@ enum HPI_CONTROL_ATTRIBUTES {
 	HPI_PAD_PROGRAM_TYPE = HPI_CTL_ATTR(PAD, 5),
 	HPI_PAD_PROGRAM_ID = HPI_CTL_ATTR(PAD, 6),
 	HPI_PAD_TA_SUPPORT = HPI_CTL_ATTR(PAD, 7),
-	HPI_PAD_TA_ACTIVE = HPI_CTL_ATTR(PAD, 8)
+	HPI_PAD_TA_ACTIVE = HPI_CTL_ATTR(PAD, 8),
+
+	HPI_UNIVERSAL_ENTITY = HPI_CTL_ATTR(UNIVERSAL, 1)
 };
 
 #define HPI_POLARITY_POSITIVE           0
@@ -425,7 +427,10 @@ enum HPI_FUNCTION_IDS {
 	HPI_ADAPTER_IRQ_QUERY_AND_CLEAR = HPI_FUNC_ID(ADAPTER, 19),
 	HPI_ADAPTER_IRQ_CALLBACK = HPI_FUNC_ID(ADAPTER, 20),
 	HPI_ADAPTER_DELETE = HPI_FUNC_ID(ADAPTER, 21),
-#define HPI_ADAPTER_FUNCTION_COUNT 21
+	HPI_ADAPTER_READ_FLASH = HPI_FUNC_ID(ADAPTER, 22),
+	HPI_ADAPTER_END_FLASH = HPI_FUNC_ID(ADAPTER, 23),
+	HPI_ADAPTER_FILESTORE_DELETE_ALL = HPI_FUNC_ID(ADAPTER, 24),
+#define HPI_ADAPTER_FUNCTION_COUNT 24
 
 	HPI_OSTREAM_OPEN = HPI_FUNC_ID(OSTREAM, 1),
 	HPI_OSTREAM_CLOSE = HPI_FUNC_ID(OSTREAM, 2),
@@ -490,7 +495,9 @@ enum HPI_FUNCTION_IDS {
 	HPI_MIXER_GET_CONTROL_MULTIPLE_VALUES = HPI_FUNC_ID(MIXER, 10),
 	HPI_MIXER_STORE = HPI_FUNC_ID(MIXER, 11),
 	HPI_MIXER_GET_CACHE_INFO = HPI_FUNC_ID(MIXER, 12),
-#define HPI_MIXER_FUNCTION_COUNT 12
+	HPI_MIXER_GET_BLOCK_HANDLE = HPI_FUNC_ID(MIXER, 13),
+	HPI_MIXER_GET_PARAMETER_HANDLE = HPI_FUNC_ID(MIXER, 14),
+#define HPI_MIXER_FUNCTION_COUNT 14
 
 	HPI_CONTROL_GET_INFO = HPI_FUNC_ID(CONTROL, 1),
 	HPI_CONTROL_GET_STATE = HPI_FUNC_ID(CONTROL, 2),
-- 
1.7.0.4
