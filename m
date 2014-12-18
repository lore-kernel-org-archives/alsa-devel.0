From: eliot@blennerhassett.gen.nz
Subject: [PATCH 3/3] asihpi: update to HPI version 4.14
Date: Thu, 18 Dec 2014 17:57:15 +1300
Message-ID: <1418878635-18960-3-git-send-email-eliot@blennerhassett.gen.nz>
References: <1418878635-18960-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 73E51261515
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 05:57:36 +0100 (CET)
Received: from mxin3-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp5.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NGR00BIZHRX7910@smtp5.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 18 Dec 2014 17:57:33 +1300 (NZDT)
In-reply-to: <1418878635-18960-1-git-send-email-eliot@blennerhassett.gen.nz>
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

This corresponds with updated asihpi firmware in alsa-firmware repo

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpi_version.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpi_version.h b/sound/pci/asihpi/hpi_version.h
index e9146e5..6623ab1 100644
--- a/sound/pci/asihpi/hpi_version.h
+++ b/sound/pci/asihpi/hpi_version.h
@@ -11,13 +11,13 @@ Production releases have even minor version.
 /* Use single digits for versions less that 10 to avoid octal. */
 /* *** HPI_VER is the only edit required to update version *** */
 /** HPI version */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4, 10, 1)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4, 14, 3)
 
 /** HPI version string in dotted decimal format */
-#define HPI_VER_STRING "4.10.01"
+#define HPI_VER_STRING "4.14.03"
 
 /** Library version as documented in hpi-api-versions.txt */
-#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(10, 2, 0)
+#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(10, 4, 0)
 
 /** Construct hpi version number from major, minor, release numbers */
 #define HPI_VERSION_CONSTRUCTOR(maj, min, r) ((maj << 16) + (min << 8) + r)
-- 
1.9.1
