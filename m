From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm9081: Fix reading wrong register for setting
 VMID 2*240k
Date: Sat, 05 Nov 2011 14:47:19 +0800
Message-ID: <1320475639.8360.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VMID Divider Enable and Select is controlled by BIT[2:1] of WM9081_VMID_CONTROL
register (04h).
Current code reads wrong register (WM9081_BIAS_CONTROL_1) for setting
VMID 2*240k.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm9081.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 3cd35a0..fe65618 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -818,7 +818,7 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* VMID 2*240k */
-		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
+		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
 		reg &= ~WM9081_VMID_SEL_MASK;
 		reg |= 0x04;
 		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
-- 
1.7.5.4
