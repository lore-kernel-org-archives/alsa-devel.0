From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add sanify check of initial pinctl
Date: Thu,  7 Feb 2013 14:24:12 +0100
Message-ID: <1360243452-21915-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C89C2652A7
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 14:24:14 +0100 (CET)
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

The pinctl in alsa-info is not the initial
pinctl but the current, so sanify the current pinctl before
accepting it as the initial pinctl. (The initial pinctl is used
during pm test.)

Several false positives in the test tool is removed
with this improvement.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-int.c           |   64 +++++++++++++++++++++++++++++++++++----------------
 hda-parse.c         |    2 ++
 include/hda-types.h |    4 ++++
 3 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/hda-int.c b/hda-int.c
index c25af56..fbd3cee 100644
--- a/hda-int.c
+++ b/hda-int.c
@@ -400,29 +400,37 @@ static int get_channel_streamid(struct xhda_codec *codec,
 	return node->streamid;
 }
 
-static int set_pin_ctl(struct xhda_codec *codec, struct xhda_node *node,
-		       unsigned int cmd)
+void hda_verify_pin_ctl(struct xhda_node *node, int log,
+			unsigned int *sanified_pinctl)
 {
-	if (!node)
-		return 0;
-	node->pinctl = cmd & 0xff;
+	int pinctl = node->pinctl;
 
 	/* sanity checks */
 	if ((node->pinctl & AC_PINCTL_OUT_EN) &&
-	    !(node->pincap & AC_PINCAP_OUT))
-		hda_log(HDA_LOG_ERR,
-			"setting OUT_EN to pin 0x%x without caps\n",
-			node->nid);
+	    !(node->pincap & AC_PINCAP_OUT)) {
+		if (log)
+			hda_log(HDA_LOG_ERR,
+				"setting OUT_EN to pin 0x%x without caps\n",
+				node->nid);
+		pinctl &= ~AC_PINCTL_OUT_EN;
+	}
 	if ((node->pinctl & AC_PINCTL_HP_EN) &&
-	    !(node->pincap & AC_PINCAP_HP_DRV))
-		hda_log(HDA_LOG_ERR,
-			"setting HP_EN to pin 0x%x without caps\n",
-			node->nid);
+	    !(node->pincap & AC_PINCAP_HP_DRV)) {
+		if (log)
+			hda_log(HDA_LOG_ERR,
+				"setting HP_EN to pin 0x%x without caps\n",
+				node->nid);
+		pinctl &= ~AC_PINCTL_HP_EN;
+	}
 	if ((node->pinctl & AC_PINCTL_IN_EN) &&
-	    !(node->pincap & AC_PINCAP_IN))
-		hda_log(HDA_LOG_ERR,
-			"setting IN_EN to pin 0x%x without caps\n",
-			node->nid);
+	    !(node->pincap & AC_PINCAP_IN)) {
+		if (log)
+			hda_log(HDA_LOG_ERR,
+				"setting IN_EN to pin 0x%x without caps\n",
+				node->nid);
+		pinctl &= ~AC_PINCTL_IN_EN;
+	}
+
 	if (node->pinctl & AC_PINCTL_IN_EN) {
 		unsigned int cap_set, cap_check;
 		const char *vref;
@@ -455,11 +463,27 @@ static int set_pin_ctl(struct xhda_codec *codec, struct xhda_node *node,
 		if (!cap_set)
 			cap_set = AC_PINCAP_VREF_HIZ;
 		if (cap_check && !(cap_set & cap_check)) {
-			hda_log(HDA_LOG_ERR,
-				"setting VREF %s to pin 0x%x without caps 0x%x\n",
-				vref, node->nid, node->pincap);
+			if (log)
+				hda_log(HDA_LOG_ERR,
+					"setting VREF %s to pin 0x%x without caps 0x%x\n",
+					vref, node->nid, node->pincap);
+			pinctl &= ~AC_PINCTL_VREFEN;
 		}
 	}
+
+	if (sanified_pinctl)
+		*sanified_pinctl = pinctl;
+}
+
+static int set_pin_ctl(struct xhda_codec *codec, struct xhda_node *node,
+		       unsigned int cmd)
+{
+	if (!node)
+		return 0;
+	node->pinctl = cmd & 0xff;
+
+	hda_verify_pin_ctl(node, 1, NULL);
+
 	return 0;
 }
 
diff --git a/hda-parse.c b/hda-parse.c
index c75b03b..d38bc04 100644
--- a/hda-parse.c
+++ b/hda-parse.c
@@ -240,6 +240,8 @@ static int parse_node_items(const char *buf)
 				      &node->orig_amp_out_vals);
 	} else if ((p = strmatch(head, "Pin-ctls: "))) {
 		node->pinctl = strtoul(p, NULL, 0);
+		if (node->pincap)
+			hda_verify_pin_ctl(node, 0, &node->pinctl);
 		node->orig_pinctl = node->pinctl;
 	} else if ((p = strmatch(head, "Pincap "))) {
 		const char *end;
diff --git a/include/hda-types.h b/include/hda-types.h
index 3754bca..68cfaa8 100644
--- a/include/hda-types.h
+++ b/include/hda-types.h
@@ -146,6 +146,10 @@ void hda_free_route_lists(struct xhda_route_list *list);
 
 void hda_show_routes(int nid, unsigned int flags);
 
+void hda_verify_pin_ctl(struct xhda_node *node, int log,
+		        unsigned int *sanified_pinctl);
+
+
 void *xalloc(size_t size);
 
 #endif /* __HDA_TYPES_H */
-- 
1.7.9.5
