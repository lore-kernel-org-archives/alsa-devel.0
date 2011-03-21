From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 14/16] ALSA: VIA HDA: Update VT1708 initial
	verbs
Date: Mon, 21 Mar 2011 15:36:51 +0800
Message-ID: <4D870013.1070905@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id B06E3103892
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:36:56 +0100 (CET)
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
Subject: ALSA: VIA HDA: Update VT1708 initial verbs.

Add a verb of power down jack detect function in VT1708 initial verbs.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1205,6 +1205,8 @@
 	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	/* power down jack detect function */
+	{0x1, 0xf81, 0x1},
 	{ }
 };
