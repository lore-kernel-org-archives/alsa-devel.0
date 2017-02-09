From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - adding a new NV HDMI/DP codec ID
	in the driver
Date: Thu,  9 Feb 2017 09:20:54 +0800
Message-ID: <1486603254-25014-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CCEDB266BC9
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 02:21:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Without this change, the HDMI/DP codec will be recognised as a
generic codec, and there is no sound when playing through this codec.

As suggested by NVidia side, after adding the new ID in the driver,
the sound playing works well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 32105ce..fd5efa7 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3780,6 +3780,7 @@ static int patch_via_hdmi(struct hda_codec *codec)
 HDA_CODEC_ENTRY(0x10de0071, "GPU 71 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0072, "GPU 72 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de007d, "GPU 7d HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de0080, "GPU 80 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0082, "GPU 82 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0083, "GPU 83 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
-- 
1.9.1
