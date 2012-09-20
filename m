From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] MOP500 Audio patches due for ASoC
Date: Thu, 20 Sep 2012 14:09:09 +0200
Message-ID: <1348142956-1872-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A6772652E6
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 14:09:24 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1314881wgb.20
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 05:09:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com
Cc: STEricsson_nomadik_linux@list.st.com, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git for-asoc-next

for you to fetch changes up to b4cad7af6665743647f28119b689e1552326d4da:

  Documentation: Define the MSP Driver Device Tree bindings (2012-09-20 09:10:59 +0200)

----------------------------------------------------------------
Lee Jones (7):
      ASoC: Ux500: Move MSP pinctrl setup into the MSP driver
      ASoC: Ux500: Enable MOP500 driver for Device Tree
      ASoC: Ux500: Enable ux500 MSP driver for Device Tree
      ASoC: codecs: Enable AB8500 CODEC for Device Tree
      ASoC: Ux500: Minor coding layout changes
      Documentation: Define the MOP500 Audio Machine Driver Device Tree bindings
      Documentation: Define the MSP Driver Device Tree bindings

 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 +++++++++
 .../devicetree/bindings/sound/ux500-msp.txt        |   43 ++++++++++
 arch/arm/mach-ux500/board-mop500-msp.c             |   79 +----------------
 arch/arm/mach-ux500/include/mach/msp.h             |    2 -
 include/linux/mfd/abx500/ab8500-codec.h            |    6 +-
 sound/soc/codecs/ab8500-codec.c                    |   81 ++++++++++++++++++
 sound/soc/ux500/mop500.c                           |   47 +++++++++--
 sound/soc/ux500/ux500_msp_dai.c                    |    6 ++
 sound/soc/ux500/ux500_msp_i2s.c                    |   89 +++++++++++++++-----
 sound/soc/ux500/ux500_msp_i2s.h                    |    8 +-
 10 files changed, 292 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
