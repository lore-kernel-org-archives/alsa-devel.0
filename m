From: linux@audioscience.com
Subject: [PATCH 09/21] Update node types.
Date: Thu, 22 Dec 2011 13:38:39 +1300
Message-ID: <1324514331-22570-10-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 379C6103C18
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:10 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:26 +1300 (NZDT)
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

Add "Internal" node type.
Remove GPI and GPO node types.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |    3 +--
 sound/pci/asihpi/hpi.h    |    5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index fff7c50..0c45638 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1317,7 +1317,7 @@ static const char * const asihpi_src_names[] = {
 	"Analog",
 	"Adapter",
 	"RTP",
-	"GPI",
+	"Internal"
 };
 
 compile_time_assert(
@@ -1335,7 +1335,6 @@ static const char * const asihpi_dst_names[] = {
 	"Net",
 	"Analog",
 	"RTP",
-	"GPO",
 };
 
 compile_time_assert(
diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 7714937..867c144 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -195,7 +195,7 @@ enum HPI_SOURCENODES {
 	/** RTP stream input node - This node is a destination for
 	    packets of RTP audio samples from other devices. */
 	HPI_SOURCENODE_RTP_DESTINATION = 112,
-	HPI_SOURCENODE_GP_IN = 113,	     /**< general purpose input. */
+	HPI_SOURCENODE_INTERNAL = 113,	     /**< node internal to the device. */
 	/* !!!Update this  AND hpidebug.h if you add a new sourcenode type!!! */
 	HPI_SOURCENODE_LAST_INDEX = 113	     /**< largest ID */
 		/* AX6 max sourcenode types = 15 */
@@ -224,9 +224,8 @@ enum HPI_DESTNODES {
 	/** RTP stream output node - This node is a source for
 	    packets of RTP audio samples that are sent to other devices. */
 	HPI_DESTNODE_RTP_SOURCE = 208,
-	HPI_DESTNODE_GP_OUT = 209,	     /**< general purpose output node. */
 	/* !!!Update this AND hpidebug.h if you add a new destnode type!!! */
-	HPI_DESTNODE_LAST_INDEX = 209	     /**< largest ID */
+	HPI_DESTNODE_LAST_INDEX = 208	     /**< largest ID */
 		/* AX6 max destnode types = 15 */
 };
 
-- 
1.7.0.4
