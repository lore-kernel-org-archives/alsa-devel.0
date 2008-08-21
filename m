From: linux@audioscience.com
Subject: [PATCH - asihpi 1/3] Fix format in portable way.
Date: Thu, 21 Aug 2008 13:29:54 +1200
Message-ID: <1219282196-20834-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@zaphod.clear.net.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@zaphod.(none)>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 12bc6ad..c56e60d 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -288,8 +288,8 @@ short HpiCheckBufferMapping(
 	sizeof(((struct hpi_control_cache_pad *)(NULL))->m) }
 
 struct pad_ofs_size {
-	size_t offset;
-	size_t field_size;
+	unsigned int offset;
+	unsigned int field_size;
 };
 
 static struct pad_ofs_size aPadDesc[] = {
@@ -441,10 +441,10 @@ short HpiCheckControlCache(
 		else {
 			unsigned int index =
 				HPI_CTL_ATTR_INDEX(phm->u.c.wAttribute) - 1;
-			size_t offset = phm->u.c.dwParam1;
-			size_t pad_string_len, field_size;
+			unsigned int offset = phm->u.c.dwParam1;
+			unsigned int pad_string_len, field_size;
 			char *pad_string;
-			size_t tocopy;
+			unsigned int tocopy;
 
 			HPI_DEBUG_LOG(VERBOSE,
 				"PADS HPI_PADS_ %d\n", phm->u.c.wAttribute);
@@ -472,7 +472,7 @@ short HpiCheckControlCache(
 				tocopy = sizeof(phr->u.cu.chars8.szData);
 
 			HPI_DEBUG_LOG(VERBOSE,
-				"PADS memcpy(%zd), offset %zd \n", tocopy,
+				"PADS memcpy(%d), offset %d \n", tocopy,
 				offset);
 			memcpy(phr->u.cu.chars8.szData, &pad_string[offset],
 				tocopy);
-- 
1.5.4.3
