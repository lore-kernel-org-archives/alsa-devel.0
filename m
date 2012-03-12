From: Liam Girdwood <lrg@ti.com>
Subject: [GIT PULL] ASoC: Updates for 3.4
Date: Mon, 12 Mar 2012 11:49:36 +0000
Message-ID: <1331552976.13303.10.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mainly Peter's McBSP move from arch/ to sound/ and updates this time.

Thanks

Liam

---


The following changes since commit 303076342b8a30aa98f8a53b539155d0b81ff0c3:

  Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc (2012-03-06 14:04:16 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc.git for-3.4

Grazvydas Ignotas (1):
      ASoC: omap-mcbsp: fix snd_pcm_hw_rule_add arguments

Peter Ujfalusi (22):
      OMAP4: panda: Correct cpu version check for 4430
      ARM: OMAP: mcbsp: Convert core driver to proper platform driver
      OMAP: mcbsp: Move core driver under sound/soc/omap
      ASoC: OMAP: McBSP: Consolidate plat/mcbsp.h content
      ASoC: omap-mcbsp: Create a single driver for McBSP
      ARM: OMAP: Do not register omap-mcbsp-dai device
      ASoC: OMAP: mcbsp.h: Clean up bit definitions
      ASoC: OMAP McBSP: Remove redundant accessors
      ASoC: omap-mcbsp: Cleanup of module probe/remove code
      ASoC: omap-mcbsp: Merge the omap_mcbsp_data into omap_mcbsp structure
      ASoC: omap-mcbsp: Simplify DMA configuration
      ASoC: omap: mcbsp: Use uniform st_data pointer initialization
      ASoC: omap: mcbsp: Remove redundant checks for the st_data pointer
      ASoC: omap-mcbsp: Configure wakeup in later phase
      ASoC: omap-mcbsp: When closing the port select PRCM source for CLKS signal
      ASoC: omap McBSP: Clear rx_irq at probe time for OMAP4
      ARM: OMAP2+: McBSP: Correct CLKR/FSR clock source mux configuration
      ARM/ASoC: OMAP McBSP: Move remainig defines from arch to ASoC header
      ASoC: omap-mcbsp: Single function CLKR/FSR source mux configuration
      ASoC: omap-mcbsp: Correct clock muxing for CLKR/FSR signals
      ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
      ASoC: OMAP: Build config cleanup for McBSP

 arch/arm/mach-omap1/Kconfig                    |    3 -
 arch/arm/mach-omap1/Makefile                   |    4 +-
 arch/arm/mach-omap1/devices.c                  |    9 -
 arch/arm/mach-omap1/mcbsp.c                    |   14 +-
 arch/arm/mach-omap2/Makefile                   |    4 +-
 arch/arm/mach-omap2/board-omap4panda.c         |    2 +-
 arch/arm/mach-omap2/devices.c                  |   22 -
 arch/arm/mach-omap2/mcbsp.c                    |   54 ++-
 arch/arm/plat-omap/Kconfig                     |    8 -
 arch/arm/plat-omap/Makefile                    |    2 -
 arch/arm/plat-omap/include/plat/mcbsp.h        |  333 --------------
 sound/soc/omap/Kconfig                         |    2 -
 sound/soc/omap/Makefile                        |    2 +-
 sound/soc/omap/am3517evm.c                     |    2 +-
 sound/soc/omap/ams-delta.c                     |    2 +-
 sound/soc/omap/igep0020.c                      |    2 +-
 {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c |  549 +++++-------------------
 sound/soc/omap/mcbsp.h                         |  346 +++++++++++++++
 sound/soc/omap/n810.c                          |    2 +-
 sound/soc/omap/omap-mcbsp.c                    |  321 ++++++++-------
 sound/soc/omap/omap-mcbsp.h                    |    2 +-
 sound/soc/omap/omap-pcm.h                      |    2 +
 sound/soc/omap/omap3beagle.c                   |    2 +-
 sound/soc/omap/omap3evm.c                      |    2 +-
 sound/soc/omap/omap3pandora.c                  |    4 +-
 sound/soc/omap/osk5912.c                       |    2 +-
 sound/soc/omap/overo.c                         |    2 +-
 sound/soc/omap/rx51.c                          |    4 +-
 sound/soc/omap/sdp3430.c                       |    4 +-
 sound/soc/omap/zoom2.c                         |    4 +-
 30 files changed, 706 insertions(+), 1005 deletions(-)
 rename {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c (66%)
 create mode 100644 sound/soc/omap/mcbsp.h


