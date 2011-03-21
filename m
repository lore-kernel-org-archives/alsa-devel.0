From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 15/16] ALSA: VIA HDA: Update VT1718S initial
	verbs
Date: Mon, 21 Mar 2011 15:37:48 +0800
Message-ID: <4D87004C.40602@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id CDDE3103892
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:37:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Update VT1718S initial verbs.

Add a verb of unmute MW0 gain 5 in VT1718S initial verbs.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -4360,7 +4360,8 @@
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 
-
+	/* Enable MW0 adjust Gain 5 */
+	{0x1, 0xfb2, 0x10},
 	/* Mute input amps (CD, Line In, Mic 1 & Mic 2) of the analog-loopback
 	 * mixer widget
 	 */
@@ -4369,7 +4370,7 @@
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
 
 	/* Setup default input of Front HP to MW9 */
 	{0x28, AC_VERB_SET_CONNECT_SEL, 0x1},
