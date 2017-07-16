From: Jan Andres <jandres@gmx.net>
Subject: [PATCH] ALSA: hda - Add hdmi id for GeForce GT 1030
Date: Sun, 16 Jul 2017 10:51:10 +0200
Message-ID: <20170716085110.GA7960@pitr.home.jan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 681272669DB
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 10:51:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

HDMI audio gets routed to the wrong HDMI/DP ports on the GT 1030.

Fix this by adding a patch entry referring to patch_nvhdmi(), like
we do for other NVidia cards.

Signed-off-by: Jan Andres <jandres@gmx.net>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d549f35f39d3..2a583c95edf6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3772,6 +3772,7 @@ HDA_CODEC_ENTRY(0x10de0071, "GPU 71 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0072, "GPU 72 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de007d, "GPU 7d HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0080, "GPU 80 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de0081, "GPU 81 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0082, "GPU 82 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0083, "GPU 83 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
-- 
2.13.3
