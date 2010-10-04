From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 4 Oct 2010 11:22:10 -0700
Message-ID: <20101004182209.GA2835@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC47624377
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 00:39:40 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 0b452f2efa35c48219d1ad3cbebdd786ec39ef06:

  Merge branch 'for-2.6.37' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2010-10-03 11:10:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Dimitris Papastamos (3):
      ASoC: WM8804: Use a proper DAI name
      ASoC: WM8804: Refactor set_pll code to avoid GCC warnings
      ASoC: WM8804: Power down the PLL correctly

Mark Brown (5):
      ASoC: Relax restrictions on WM8962 BCLK configuration
      ASoC: Remove -dai suffix from i.MX SSI driver
      ASoC: Add support for WM8962 GPIO outputs
      ASoC: Implement interrupt based jack detection
      ASoC: Put WM8962 GPIO2/3 into GPIO mode when configuring platform data too

 arch/arm/mach-mx3/clock-imx31.c |    4 +-
 arch/arm/mach-mx3/clock-imx35.c |    4 +-
 arch/arm/mach-mx3/devices.c     |    4 +-
 arch/arm/plat-mxc/audmux-v2.c   |    4 +-
 include/sound/wm8962.h          |    1 +
 sound/soc/codecs/wm8804.c       |   49 +++++----
 sound/soc/codecs/wm8962.c       |  228 +++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8962.h       |    4 +
 sound/soc/imx/eukrea-tlv320.c   |    2 +-
 sound/soc/imx/imx-ssi.c         |    2 +-
 sound/soc/imx/phycore-ac97.c    |    2 +-
 sound/soc/imx/wm1133-ev1.c      |    2 +-
 12 files changed, 265 insertions(+), 41 deletions(-)
