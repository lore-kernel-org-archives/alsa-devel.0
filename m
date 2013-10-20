From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 DTS 0/4] Fix AM335x-evm analog audio support
Date: Sun, 20 Oct 2013 20:04:07 +0300
Message-ID: <cover.1382288454.git.jsarha@ti.com>
References: <52615C70.30307@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <52615C70.30307@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Benoit,
I rebased the DTS patches on top of 
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git 
for_3.13/dts -branch
and tested the result. Hope that was the right branch.

The DTS patches can also be pulled from:
git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git
for_bcousson/for_3.13/dts -branch

The non DTS patches rebased on top of v3.12-rc5 can be pulled from here:
git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git
v3.12-rc5-am33xx-audio-patch-v5-no-dts -branch

The the full patch series can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067443.html

Best regards,
Jyri

Darren Etheridge (1):
  ARM/dts: am335x-evm: Add audio support for am335x-evm.dts

Jyri Sarha (1):
  ARM/dts: am33xx: mcasp: Add location for data port registers to
    reg-property

Pantelis Antoniou (1):
  ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries

Peter Ujfalusi (1):
  ARM/dts: am335x-evmsk: Audio support

 arch/arm/boot/dts/am335x-evm.dts   |   50 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   48 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi      |   28 ++++++++++++++++++++
 3 files changed, 126 insertions(+)

-- 
1.7.9.5

