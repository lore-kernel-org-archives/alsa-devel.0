From: codekipper@gmail.com
Subject: [PATCH v2 0/2] ASoC: sun4i-spdif: Add support for the H3 SoC
Date: Thu, 19 Jan 2017 20:52:56 +0100
Message-ID: <20170119195258.29652-1-codekipper@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: maxime.ripard@free-electrons.com
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper@gmail.com>

The H3 SoC uses the same SPDIF block as found in earlier SoCs, but the
transmit fifo is at a different address.

This has been tested on the Beelink X2.
BR,
CK
---
Changes since v1:
 - Now a patch set with bindings and driver changes.
---
Marcus Cooper (2):
  ASoC: sunxi: Add bindings for sun8i to SPDIF
  ASoC: sun4i-spdif: Add support for the H3 SoC

 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt |  1 +
 sound/soc/sunxi/sun4i-spdif.c                                 | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- 
2.11.0
