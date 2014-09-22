From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/5] hda-spec: Add more secret nodes for
	Realtek codecs
Date: Mon, 22 Sep 2014 13:09:04 +0200
Message-ID: <1411384146-23286-4-git-send-email-david.henningsson@canonical.com>
References: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 510C0265294
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:12 +0200 (CEST)
In-Reply-To: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/hda-spec.c b/hda-spec.c
index fa21cf5..935dcc0 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -462,17 +462,26 @@ static int realtek_ext_cmd(struct xhda_codec *codec, unsigned int cmd)
 {
 	unsigned int nid = (cmd >> 20) & 0x7f;
 
+	codec->rc = 0;
+
 	/* just ignore COEFs on ALC260 for non-existing NID 0x20 */
-	if (codec->vendor_id == 0x10ec0260 && nid == 0x20) {
-		codec->rc = 0;
+	if (codec->vendor_id == 0x10ec0260 && nid == 0x20)
+		return 0;
+
+	if (codec->vendor_id == 0x10ec0283 && nid == 0x53)
+		return 0;
+
+	if (codec->vendor_id == 0x10ec0255 && nid == 0x57)
+		return 0;
+
+	if (codec->vendor_id == 0x10ec0293 && nid == 0x57)
 		return 0;
-	}
 
-	if (nid != 0x51)
-		return -ENXIO;
 	/* There might be a secret DSP connected to node 0x51 */
-	codec->rc = 0;
-	return 0;
+	if (nid == 0x51)
+		return 0;
+
+	return -ENXIO;
 }
 
 /*
-- 
1.9.1
