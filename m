From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add new HDMI commands
Date: Fri, 23 May 2014 15:58:24 +0200
Message-ID: <1400853504-17405-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DD046264F28
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 15:58:27 +0200 (CEST)
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

Some new HDMI commands were added recently to the HDA driver.
This patch makes hda-emu support these new commands (or at least,
not output errors).

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-int.c           | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hda-types.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/hda-int.c b/hda-int.c
index ef90fe8..6dd862d 100644
--- a/hda-int.c
+++ b/hda-int.c
@@ -823,6 +823,52 @@ static int get_cvt_channel_count(struct xhda_codec *codec,
 	return node->cvt_channel_count;
 }
 
+static int get_asp_channel_slot(struct xhda_codec *codec,
+				struct xhda_node *node, unsigned int cmd)
+{
+	return (node->asp_channel_slot[cmd & 0xf] << 4) + (cmd & 0xf);
+}
+
+static int set_asp_channel_slot(struct xhda_codec *codec,
+				struct xhda_node *node, unsigned int cmd)
+{
+	node->asp_channel_slot[cmd & 0xf] = (cmd & 0xf0) >> 4;
+	return 0;
+}
+
+static int set_dip_index(struct xhda_codec *codec,
+			 struct xhda_node *node, unsigned int cmd)
+{
+	return 0; /* FIXME */
+}
+
+static int set_dip_data(struct xhda_codec *codec,
+			struct xhda_node *node, unsigned int cmd)
+{
+	return 0; /* FIXME */
+}
+
+static int get_dip_size(struct xhda_codec *codec,
+			struct xhda_node *node, unsigned int cmd)
+{
+	if (cmd & 0x8)
+		return 128; /* ELD buffer size */
+	return 32; /* DIP buffer size */
+}
+
+static int set_dip_xmitctrl(struct xhda_codec *codec,
+			    struct xhda_node *node, unsigned int cmd)
+{
+	node->dip_xmitctrl = cmd & 0xc0;
+	return 0;
+}
+
+static int get_dip_xmitctrl(struct xhda_codec *codec,
+			    struct xhda_node *node, unsigned int cmd)
+{
+	return node->dip_xmitctrl;
+}
+
 
 /*
  * parameters
@@ -1063,6 +1109,10 @@ static struct xhda_verb_table verb_tbl[] = {
 	{ 0x71e, set_config_def_2, "set_config_def_2" },
 	{ 0x71f, set_config_def_3, "set_config_def_3" },
 	{ 0x72d, set_cvt_channel_count, "set_cvt_channel_count" },
+	{ 0x730, set_dip_index, "set_dip_index" },
+	{ 0x731, set_dip_data, "set_dip_data" },
+	{ 0x732, set_dip_xmitctrl, "set_dip_xmitctrl" },
+	{ 0x734, set_asp_channel_slot, "set_asp_channel_slot" },
 	{ 0x7ff, set_codec_reset, "set_codec_reset" },
 	{ 0xf00, get_parameters, "get_parameters" },
 	{ 0xf01, get_connect_sel, "get_connect_sel" },
@@ -1087,6 +1137,9 @@ static struct xhda_verb_table verb_tbl[] = {
 	{ 0xf1c, get_config_default, "get_config_default" },
 	{ 0xf20, get_ssid, "get_ssid" },
 	{ 0xf2d, get_cvt_channel_count, "get_cvt_channel_count" },
+	{ 0xf2e, get_dip_size, "get_dip_size" },
+	{ 0xf32, get_dip_xmitctrl, "get_dip_xmitctrl" },
+	{ 0xf34, get_asp_channel_slot, "get_asp_channel_slot" },
 	{}
 };
 
diff --git a/include/hda-types.h b/include/hda-types.h
index fe6b31f..46bfc67 100644
--- a/include/hda-types.h
+++ b/include/hda-types.h
@@ -58,6 +58,8 @@ struct xhda_node {
 	unsigned char gpio_wake, gpio_unsol, gpio_sticky;
 	unsigned int coef_idx;
 	unsigned char cvt_channel_count;
+	unsigned char asp_channel_slot[16];
+	unsigned char dip_xmitctrl;
 	struct xhda_coef_table *coef_tbl;
 	struct xhda_node *next;
 };
-- 
1.9.1
