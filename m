From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/hdmi - Remove duplicated define
Date: Tue, 16 Jul 2019 09:42:54 +0200
Message-ID: <20190716074255.14267-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B24FF800C4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2019 09:42:59 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Hui Wang <hui.wang@canonical.com>
List-Id: alsa-devel@alsa-project.org

INTEL_GET_VENDOR_VERB is defined twice identically.
Let's remove a superfluous line.

Fixes: b0d8bc50b9f2 ("ALSA: hda: hdmi - add Icelake support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 40323d91f9e4..1e6c489bca15 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2416,7 +2416,6 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 	snd_hda_override_conn_list(codec, nid, spec->num_cvts, spec->cvt_nids);
 }
 
-#define INTEL_GET_VENDOR_VERB	0xf81
 #define INTEL_GET_VENDOR_VERB	0xf81
 #define INTEL_SET_VENDOR_VERB	0x781
 #define INTEL_EN_DP12		0x02	/* enable DP 1.2 features */
-- 
2.16.4
