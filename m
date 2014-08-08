From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 1/2] ALSA: hda - Set internal mic as default
	input source on Dell XPS 13 9333
Date: Fri,  8 Aug 2014 19:34:40 +0200
Message-ID: <ea95dd5e4c41ae06b15369b9acf15085d4a4e2fa.1407518135.git.gabriele.mzt@gmail.com>
References: <cover.1407518135.git.gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C930A265554
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 19:35:14 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id b13so5879197wgh.18
 for <alsa-devel@alsa-project.org>; Fri, 08 Aug 2014 10:35:14 -0700 (PDT)
In-Reply-To: <cover.1407518135.git.gabriele.mzt@gmail.com>
In-Reply-To: <cover.1407518135.git.gabriele.mzt@gmail.com>
References: <cover.1407518135.git.gabriele.mzt@gmail.com>
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: alsa-devel@alsa-project.org

If the laptop is powered on with a jack plugged in, independently on what
is plugged, the jack is treated as a microphone jack.

Initialize the capture source so that by default jacks are treated as
headphones jacks. This will also prevent pop noises on boot in case
headphones are plugged in since setting/unsetting mic-in as input source
causes a pop noise.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=76611
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b60824e..85cd80c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4018,8 +4018,19 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
 {
 	if (action == HDA_FIXUP_ACT_PROBE) {
 		struct alc_spec *spec = codec->spec;
+		struct hda_input_mux *imux = &spec->gen.input_mux;
+		int i;
+
 		spec->shutup = alc_no_shutup;
 		codec->power_filter = alc_power_filter_xps13;
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
