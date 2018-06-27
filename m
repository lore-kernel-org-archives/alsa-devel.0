From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda/hdmi - Don't fall back to
	generic when i915 binding fails
Date: Wed, 27 Jun 2018 11:10:34 +0200
Message-ID: <20180627091034.22724-4-tiwai@suse.de>
References: <20180627091034.22724-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F38B926795B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 11:10:39 +0200 (CEST)
In-Reply-To: <20180627091034.22724-1-tiwai@suse.de>
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

When i915 component binding fails, it means that HDMI isn't applicable
anyway.  Although the probe with the generic HDMI parser would still
work, it's essentially useless, hence better to be left unbound.

This patch mimics the probe_id field at failing the i915 component
binding so that the generic HDMI won't be bound after that.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c182e619ad58..1fed59f8ed32 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2542,6 +2542,8 @@ static int alloc_intel_hdmi(struct hda_codec *codec)
 	/* requires i915 binding */
 	if (!codec->bus->core.audio_component) {
 		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
+		/* set probe_id here to prevent generic fallback binding */
+		codec->probe_id = HDA_CODEC_ID_GENERIC_HDMI;
 		return -ENODEV;
 	}
 
-- 
2.17.1
