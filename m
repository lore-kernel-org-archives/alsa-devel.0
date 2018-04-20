From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/8] arm: renesas: Change platform dependency
	to ARCH_RENESAS
Date: Fri, 20 Apr 2018 15:28:26 +0200
Message-ID: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7ED2673D8
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 15:28:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

	Hi all,

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
ARM SoCs.  This patch series completes the conversion, by:
  1. Updating dependencies for drivers that weren't converted yet,
  2. Removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.

The first 6 patches can be applied independently by subsystem
maintainers.
The last two patches depend on the first 6 patches, and are thus marked
RFC.

Thanks for your comments!

Geert Uytterhoeven (8):
  arm: shmobile: Change platform dependency to ARCH_RENESAS
  dmaengine: shdmac: Change platform check to CONFIG_ARCH_RENESAS
  [media] v4l: rcar_fdp1: Change platform dependency to ARCH_RENESAS
  sh_eth: Change platform check to CONFIG_ARCH_RENESAS
  staging: emxx_udc: Change platform dependency to ARCH_RENESAS
  ASoC: sh: Update menu title and platform dependency
  [RFC] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
  [RFC] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

 arch/arm/Kconfig                      |  2 +-
 arch/arm/Makefile                     |  2 +-
 arch/arm/mach-shmobile/Kconfig        |  4 ---
 arch/arm64/Kconfig.platforms          | 42 +++++++++++++----------------
 drivers/dma/sh/shdmac.c               | 50 +++++++++++++++--------------------
 drivers/media/platform/Kconfig        |  2 +-
 drivers/net/ethernet/renesas/sh_eth.h |  2 +-
 drivers/staging/emxx_udc/Kconfig      |  2 +-
 sound/soc/sh/Kconfig                  |  4 +--
 9 files changed, 47 insertions(+), 63 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
