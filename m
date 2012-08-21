From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/5] hda-emu: Add support for get/set converter
	channel count
Date: Tue, 21 Aug 2012 10:54:00 +0200
Message-ID: <1345539243-8147-3-git-send-email-david.henningsson@canonical.com>
References: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3F7265EE9
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:11 +0200 (CEST)
In-Reply-To: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
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

This verb is used by the HDMI playback engine.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-int.c           |   15 +++++++++++++++
 include/hda-types.h |    1 +
 2 files changed, 16 insertions(+)

diff --git a/hda-int.c b/hda-int.c
index f4cbdcb..c25af56 100644
--- a/hda-int.c
+++ b/hda-int.c
@@ -786,6 +786,19 @@ static int get_gpio_sticky_mask(struct xhda_codec *codec,
 	return node->gpio_sticky;
 }
 
+static int set_cvt_channel_count(struct xhda_codec *codec,
+				struct xhda_node *node, unsigned int cmd)
+{
+	node->cvt_channel_count = cmd & 0xff;
+	return 0;
+}
+
+static int get_cvt_channel_count(struct xhda_codec *codec,
+				struct xhda_node *node, unsigned int cmd)
+{
+	return node->cvt_channel_count;
+}
+
 
 /*
  * parameters
@@ -1025,6 +1038,7 @@ static struct xhda_verb_table verb_tbl[] = {
 	{ 0x71d, set_config_def_1, "set_config_def_1" },
 	{ 0x71e, set_config_def_2, "set_config_def_2" },
 	{ 0x71f, set_config_def_3, "set_config_def_3" },
+	{ 0x72d, set_cvt_channel_count, "set_cvt_channel_count" },
 	{ 0x7ff, set_codec_reset, "set_codec_reset" },
 	{ 0xf00, get_parameters, "get_parameters" },
 	{ 0xf01, get_connect_sel, "get_connect_sel" },
@@ -1048,6 +1062,7 @@ static struct xhda_verb_table verb_tbl[] = {
 	{ 0xf1a, get_gpio_sticky_mask, "get_gpio_sticky_mask" },
 	{ 0xf1c, get_config_default, "get_config_default" },
 	{ 0xf20, get_ssid, "get_ssid" },
+	{ 0xf2d, get_cvt_channel_count, "get_cvt_channel_count" },
 	{}
 };
 
diff --git a/include/hda-types.h b/include/hda-types.h
index 2508726..3a06745 100644
--- a/include/hda-types.h
+++ b/include/hda-types.h
@@ -54,6 +54,7 @@ struct xhda_node {
 	unsigned char gpio_data, gpio_dir, gpio_mask;
 	unsigned char gpio_wake, gpio_unsol, gpio_sticky;
 	unsigned int coef_idx;
+	unsigned char cvt_channel_count;
 	struct xhda_coef_table *coef_tbl;
 	struct xhda_node *next;
 };
-- 
1.7.9.5
