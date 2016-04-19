From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Keep powering up ADCs on Cirrus
	codecs
Date: Tue, 19 Apr 2016 22:14:03 +0200
Message-ID: <1461096843-16838-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A216126262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 22:14:08 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3C6F7ABD0
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 20:14:05 +0000 (UTC)
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

Although one weird behavior about the input path (inconsistent D0/D3
switch) on Cirrus CS420x codecs was fixed in the previous commit,
there is still an issue on some Mac machines: the capture stream
stalls when switching the ADCs on the fly.  More badly, this keeps
stuck until the next reboot.

The dynamic ADC switching is already a bit fragile and assuming
optimistically that the chip accepts the frequent power changes.  On
Cirrus codecs, this doesn't seem applicable.

As a quick workaround, we pin down the ADCs to keep up in D0 when
spec->dyn_adc_switch is set.  In this way, the ADCs are kept up only
for the system that were confirmed to be broken.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116171
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index a47e8ae0eb30..80bbadc83721 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -361,6 +361,7 @@ static int cs_parse_auto_config(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
 	int err;
+	int i;
 
 	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, 0);
 	if (err < 0)
@@ -370,6 +371,19 @@ static int cs_parse_auto_config(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
+	/* keep the ADCs powered up when it's dynamically switchable */
+	if (spec->gen.dyn_adc_switch) {
+		unsigned int done = 0;
+		for (i = 0; i < spec->gen.input_mux.num_items; i++) {
+			int idx = spec->gen.dyn_adc_idx[i];
+			if (done & (1 << idx))
+				continue;
+			snd_hda_gen_fix_pin_power(codec,
+						  spec->gen.adc_nids[idx]);
+			done |= 1 << idx;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.8.1
