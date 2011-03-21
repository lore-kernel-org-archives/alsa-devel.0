From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 16/16] ALSA: VIA HDA: Update VT2002P initial
	verbs
Date: Mon, 21 Mar 2011 15:38:38 +0800
Message-ID: <4D87007E.5000505@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id EC459103892
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:38:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Update VT2002P initial verbs.

Add some hardware related verbs in VT2002P initial verbs.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -5375,6 +5375,10 @@
 };
 
 static struct hda_verb vt2002P_volume_init_verbs[] = {
+	/* Hardware verbs */
+	{0x1, 0xfe0, 0x4},
+	{0x1, 0xfe9, 0x80},
+	{0x1, 0xfe2, 0x22},
 	/*
 	 * Unmute ADC0-1 and set the default input to mic-in
 	 */
