From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/5] hda-spec: Add fixups for Haswell/Broadwell
	HDMI
Date: Mon, 22 Sep 2014 13:09:02 +0200
Message-ID: <1411384146-23286-2-git-send-email-david.henningsson@canonical.com>
References: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 97D7D265262
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:10 +0200 (CEST)
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
 hda-spec.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hda-spec.c b/hda-spec.c
index 58dd87a..0ff0388 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -271,6 +271,12 @@ static struct xhda_verb_table nvhdmi_8ch_7x_verbs[] = {
 	{ } /* terminator */
 };
 
+static struct xhda_verb_table haswellhdmi_verbs[] = {
+	{ 0x781, set_cached_verb, "intelhdmi_set_vendor_verb" },
+	{ 0xf81, get_cached_verb, "intelhdmi_get_vendor_verb" },
+	{ } /* terminator */
+};
+
 /*
  */
 
@@ -445,6 +451,10 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x10de0006, .verbs = nvhdmi_8ch_7x_verbs },
 	{ .id = 0x10de0007, .verbs = nvhdmi_8ch_7x_verbs },
 
+	/* Haswell/Broadwell HDMI */
+	{ .id = 0x80862807, .verbs = haswellhdmi_verbs },
+	{ .id = 0x80862808, .verbs = haswellhdmi_verbs },
+
 	{ }
 };
 
@@ -565,6 +575,35 @@ static void fixup_alc268_beep(struct xhda_codec *codec)
 	node->amp_in_caps.override = 1;
 }
 
+static void fixup_haswellhdmi(struct xhda_codec *codec)
+{
+	struct xhda_node *node;
+
+	/* Haswell can run in two modes: either with one cvt 0x2 and one pin 0x3,
+	   or three cvts 0x2, 0x3, 0x4 and three pins 0x5, 0x6, 0x7.
+	   But the connection can be broken in either case. */
+
+	if (find_node(codec, 0x05)) {
+		int nid;
+		for (nid = 0x05; nid <= 0x07; nid++) {
+			node = find_node(codec, nid);
+			if (node) {
+				node->num_nodes = 3;
+				node->node[0] = 0x2;
+				node->node[1] = 0x3;
+				node->node[2] = 0x4;
+			}
+		}
+	}
+	else {
+		node = find_node(codec, 0x03);
+		if (node) {
+			node->num_nodes = 1;
+			node->node[0] = 0x2;
+		}
+	}
+}
+
 struct fixup_list {
 	unsigned int vendor_id;
 	void (*func)(struct xhda_codec *);
@@ -603,6 +642,9 @@ static struct fixup_list fixups[] = {
 	{ 0x11064761, fixup_vt3476 },
 	{ 0x11064762, fixup_vt3476 },
 
+	{ 0x80862807, fixup_haswellhdmi },
+	{ 0x80862808, fixup_haswellhdmi },
+
 	{ }
 };
 
-- 
1.9.1
