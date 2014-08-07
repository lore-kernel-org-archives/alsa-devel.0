From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] ALSA: hda - More pop noise fixes for Dell XPS
	13 9333
Date: Thu, 07 Aug 2014 18:35:39 +0200
Message-ID: <20698834.dnBpTPPJ84@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CDC2265139
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 18:36:00 +0200 (CEST)
Received: by mail-wi0-f172.google.com with SMTP id n3so11069306wiv.5
 for <alsa-devel@alsa-project.org>; Thu, 07 Aug 2014 09:36:00 -0700 (PDT)
Received: from xps13.localnet (2-235-140-64.ip228.fastwebnet.it.
 [2.235.140.64])
 by mx.google.com with ESMTPSA id 10sm10989783wjr.22.2014.08.07.09.35.58
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Aug 2014 09:35:58 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

On init, mic-in is always set as input source, indipendently on what
is plugged in. Since setting/unsetting mic-in as input source causes
a pop noise, make sure the internal microphone is selected as input
source on boot.

On shutdown, make sure the codec is not suspended as that would cause
a pop noise.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/hda_codec.c     |  2 ++
 sound/pci/hda/hda_codec.h     |  1 +
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4c20277..92d8292 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5348,6 +5348,8 @@ void snd_hda_bus_reboot_notify(struct hda_bus *bus)
 	if (!bus)
 		return;
 	list_for_each_entry(codec, &bus->codec_list, list) {
+		if (codec->resume_at_reboot)
+			hda_call_codec_resume(codec);
 		if (hda_codec_is_power_on(codec) &&
 		    codec->patch_ops.reboot_notify)
 			codec->patch_ops.reboot_notify(codec);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 5825aa1..5c3c66e 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -366,6 +366,7 @@ struct hda_codec {
 	unsigned int cached_write:1;	/* write only to caches */
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
+	unsigned int resume_at_reboot:1; /* resume codec at reboot */
 #ifdef CONFIG_PM
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b60824e..defaa2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4018,8 +4018,20 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
 {
 	if (action == HDA_FIXUP_ACT_PROBE) {
 		struct alc_spec *spec = codec->spec;
+		struct hda_input_mux *imux = &spec->gen.input_mux;
+		int i;
+
 		spec->shutup = alc_no_shutup;
 		codec->power_filter = alc_power_filter_xps13;
+		codec->resume_at_reboot = 1;
+
+		/* Make the internal mic the default input source. */
+		for (i = 0; i < imux->num_items; i++) {
+			if (spec->gen.imux_pins[i] == 0x12) {
+				spec->gen.cur_mux[0] = i;
+				break;
+			}
+		}
 	}
 }
 
-- 
2.1.0.rc1
