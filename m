From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH RFC 1/3] ALSA: hdmi - fix channel_allocation
	array wrong order
Date: Wed,  5 Sep 2012 13:58:36 +0800
Message-ID: <1346824718-18448-2-git-send-email-xingchao.wang@intel.com>
References: <1346824718-18448-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF702652DF
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 08:11:53 +0200 (CEST)
In-Reply-To: <1346824718-18448-1-git-send-email-xingchao.wang@intel.com>
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
Cc: tiwai@suse.de, anssi.hannula@iki.fi, alanwww1@xbmc.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

The array channel_allocations[] is an ordered list, add function to get
correct order by ca_index.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/patch_hdmi.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d9439c5..6ac21d4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -469,6 +469,17 @@ static void init_channel_allocations(void)
 	}
 }
 
+static int get_channel_allocation_order(int ca)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(channel_allocations); i++) {
+		if (channel_allocations[i].ca_index == ca)
+			break;
+	}
+	return i;
+}
+
 /*
  * The transformation takes two steps:
  *
@@ -541,9 +552,11 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 {
 	int i;
 	int err;
+	int order;
 
+	order = get_channel_allocation_order(ca);
 	if (hdmi_channel_mapping[ca][1] == 0) {
-		for (i = 0; i < channel_allocations[ca].channels; i++)
+		for (i = 0; i < channel_allocations[order].channels; i++)
 			hdmi_channel_mapping[ca][i] = i | (i << 4);
 		for (; i < 8; i++)
 			hdmi_channel_mapping[ca][i] = 0xf | (i << 4);
-- 
1.7.9.5
