From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 3/16] ALSA: VIA HDA: Update unsolicited event
	function
Date: Mon, 21 Mar 2011 15:24:49 +0800
Message-ID: <4D86FD41.5090407@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B60D24382
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:24:53 +0100 (CET)
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
Subject: ALSA: VIA HDA: Update unsolicited event function.

Update unsolicited event function via_unsol_event() to process more
unsolicited events.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -224,12 +224,12 @@
 	return codec_type;
 };
 
+#define VIA_JACK_EVENT		0x20
 #define VIA_HP_EVENT		0x01
 #define VIA_GPIO_EVENT		0x02
-#define VIA_JACK_EVENT		0x04
-#define VIA_MONO_EVENT		0x08
-#define VIA_SPEAKER_EVENT	0x10
-#define VIA_BIND_HP_EVENT	0x20
+#define VIA_MONO_EVENT		0x03
+#define VIA_SPEAKER_EVENT	0x04
+#define VIA_BIND_HP_EVENT	0x05
 
 enum {
 	VIA_CTL_WIDGET_VOL,
@@ -1705,17 +1705,21 @@
 				  unsigned int res)
 {
 	res >>= 26;
-	if (res & VIA_HP_EVENT)
-		via_hp_automute(codec);
-	if (res & VIA_GPIO_EVENT)
-		via_gpio_control(codec);
+
 	if (res & VIA_JACK_EVENT)
 		set_widgets_power_state(codec);
-	if (res & VIA_MONO_EVENT)
+
+	res &= ~VIA_JACK_EVENT;
+
+	if (res == VIA_HP_EVENT)
+		via_hp_automute(codec);
+	else if (res == VIA_GPIO_EVENT)
+		via_gpio_control(codec);
+	else if (res == VIA_MONO_EVENT)
 		via_mono_automute(codec);
-	if (res & VIA_SPEAKER_EVENT)
+	else if (res == VIA_SPEAKER_EVENT)
 		via_speaker_automute(codec);
-	if (res & VIA_BIND_HP_EVENT)
+	else if (res == VIA_BIND_HP_EVENT)
 		via_hp_bind_automute(codec);
 }
