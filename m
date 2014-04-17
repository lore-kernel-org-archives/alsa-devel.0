From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/5] Simple-audio-card support for HP t5325
Date: Thu, 17 Apr 2014 17:53:09 +0200
Message-ID: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 698AF260376
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 17:55:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jason Cooper <jason@lakedaemon.net>, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>
List-Id: alsa-devel@alsa-project.org

This patchset allows the Kirkwood based HP t5325 device make use of
simple-card to instantiate its audio hardware.

Patch 1 Adds a DT binding to the ALC5623 codec
Patch 2 Makes use of this new binding
Patch 3 Add fixes up the kirkwood sound node in DT
Patch 4 Extends simple-card to support the hw_params() needed
        when using MVEBU sound hardware.
Patch 5 Swaps t5323 to using DT, removing all need for C code.

Andrew Lunn (5):
  ASoC: alc5623: Add device tree binding
  ARM: Kirkwood: Use DT to instansiate codec
  ARM: Kirkwood: DT: Add missing #sound-dai-cells property
  ASoC: simple-card: Support setting mclk via a fixed factor
  ARM: Kirkwood: t5325: Use simple-card to instantiate audio

 .../devicetree/bindings/sound/alc5623.txt          | 23 ++++++++++++
 .../devicetree/bindings/sound/simple-card.txt      |  2 ++
 arch/arm/boot/dts/kirkwood-t5325.dts               | 33 +++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  1 +
 arch/arm/mach-mvebu/board-t5325.c                  | 41 ----------------------
 arch/arm/mach-mvebu/board.h                        |  6 ----
 arch/arm/mach-mvebu/kirkwood.c                     |  3 --
 sound/soc/codecs/alc5623.c                         | 13 +++++++
 sound/soc/generic/simple-card.c                    | 28 +++++++++++++++
 9 files changed, 100 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 delete mode 100644 arch/arm/mach-mvebu/board-t5325.c

-- 
1.9.2
