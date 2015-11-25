From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH] ASoC: rockchip: Fix incorrect VDW value for 24 bit
Date: Wed, 25 Nov 2015 09:54:11 +0100
Message-ID: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Correct valid data word register value for 24 bit data width. The
bit value should be 10 (aka 0x2), not 0x10.

This fixes playback of 24 bit audio.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 sound/soc/rockchip/rockchip_spdif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
index 07f86a2..921b409 100644
--- a/sound/soc/rockchip/rockchip_spdif.h
+++ b/sound/soc/rockchip/rockchip_spdif.h
@@ -28,9 +28,9 @@
 #define SPDIF_CFGR_VDW(x)	(x << SPDIF_CFGR_VDW_SHIFT)
 #define SDPIF_CFGR_VDW_MASK	(0xf << SPDIF_CFGR_VDW_SHIFT)
 
-#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x00)
-#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x01)
-#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x10)
+#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x0)
+#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x1)
+#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x2)
 
 /*
  * DMACR
-- 
2.6.2
