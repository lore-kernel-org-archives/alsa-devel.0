From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 4/30] ALSA: HDA VIA: Limit VT1702 AA-Path max
	volume
Date: Sat, 10 Oct 2009 19:07:32 +0800
Message-ID: <4AD06AF4.4090704@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 041A6103842
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:07:29 +0200 (CEST)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Limit VT1702 AA-Path max volume

according to customer request, VT1702 AA-Path max volume (12 dB) is too
high, so limit to 0 dB.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3166,6 +3166,12 @@
 	err = vt1702_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
 	if (err < 0)
 		return err;
+	/* limit AA path volume to 0 dB */
+	snd_hda_override_amp_caps(codec, 0x1A, HDA_INPUT,
+				  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x5 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (1 << AC_AMPCAP_MUTE_SHIFT));
 	err = vt1702_auto_create_analog_input_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
