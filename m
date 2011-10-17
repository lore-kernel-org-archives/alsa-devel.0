From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm9081: Fix setting soft VMID ramp enable with
 VMID 2*240k
Date: Mon, 17 Oct 2011 12:34:31 +0800
Message-ID: <1318826071.12989.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to the datasheet:
BIT 2:1
        VMID_SEL[1:0] VMID Divider Enable and Select
        00 = VMID disabled
        01 = 2x40k Omh divider
        10 = 2x240k Omh divider
        11 = 2x5k Omh divider

To set VMID 2*240k, we should OR reg with 0x04 instead of 0x40.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm9081.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index b2d3448..66092ef 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -819,7 +819,7 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 		/* VMID 2*240k */
 		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg &= ~WM9081_VMID_SEL_MASK;
-		reg |= 0x40;
+		reg |= 0x04;
 		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 		/* Standby bias current on */
-- 
1.7.4.1
