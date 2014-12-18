From: eliot@blennerhassett.gen.nz
Subject: [PATCH 2/3] ALSA: asihpi: increase tuner pad cache size
Date: Thu, 18 Dec 2014 17:57:14 +1300
Message-ID: <1418878635-18960-2-git-send-email-eliot@blennerhassett.gen.nz>
References: <1418878635-18960-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id B65CD261536
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 05:57:51 +0100 (CET)
Received: from mxin3-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NGR0037XHRVN720@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 18 Dec 2014 17:57:31 +1300 (NZDT)
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

Increase size allocated for PAD (programme associated data) control.
This is used by newer tuner products.

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpi_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 48380ce..aeea679 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -1367,9 +1367,9 @@ struct hpi_control_cache_single {
 struct hpi_control_cache_pad {
 	struct hpi_control_cache_info i;
 	u32 field_valid_flags;
-	u8 c_channel[8];
-	u8 c_artist[40];
-	u8 c_title[40];
+	u8 c_channel[40];
+	u8 c_artist[100];
+	u8 c_title[100];
 	u8 c_comment[200];
 	u32 pTY;
 	u32 pI;
-- 
1.9.1
