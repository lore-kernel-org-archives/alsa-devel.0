From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V4 0/3] sound:soc: jz4740: Add DT, dynamic sampling
Date: Tue, 3 Feb 2015 10:55:56 +0000
Message-ID: <1422960959-40403-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Zubair.Kakakhel@imgtec.com
List-Id: alsa-devel@alsa-project.org

Hi,

Here are a few simple patches for the jz4740.

First adds dynamic sampling support to jz4740-i2s.
Then two to add a simple binding and DT support.
Then a patch to set the clock rate for i2s.

These are in preparation for jz4780 and ci20 later on.

Patches are based on 3.19-rc7. Quite disjoint and stay within jz4740 
so should apply easily on other trees.

If you would like to have them rebased to a different tree, please tell.

Thank-you

V4 changes: 
Added Acked-by: Lars-Peter Clausen <lars@metafoo.de> 
Rebased on 3.19-rc7
Removed patch 4 which was redundant

V3 changes:
Added dma binding to example but forgot to put it in required properties.

V2 changes: 
Removed a redundant #define
Added #ifdef CONFIG_OF
Added dma in binding document
Removed a redundant call to clk_prepare_enable

Zubair Lutfullah Kakakhel (3):
  sound: soc: jz4740: Add dynamic sampling rate support to jz4740-i2s
  dt: sound: jz4740: Add binding documentation for jz4740-i2s
  sound: soc: jz4740: Add DT support to jz4740-i2s driver

 .../bindings/sound/ingenic,jz4740-i2s.txt          | 23 ++++++++++++++++++++++
 sound/soc/jz4740/jz4740-i2s.c                      | 21 +++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt

-- 
1.9.1
