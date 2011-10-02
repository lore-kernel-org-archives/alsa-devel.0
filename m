From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] ASoC fixes from ARM randconfig builds
Date: Sun,  2 Oct 2011 22:27:58 +0200
Message-ID: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

As promised, here are the remaining ASoC patches from my
randconfig series. I hope I managed to get the submission
right this time. I've left out the ones that you already
took or NAKed, so this is shorter than I expected.

	Arnd

Arnd Bergmann (6):
  ASoC: codecs/wm8682: use __devexit_p
  ASoC: codecs: AK4641 depends on GPIOLIB
  ASoC: imx: eukrea_tlv320 needs i2c
  ASoC: sh: use correct __iomem annotations
  ASoC: samsung: fix Kconfig dependencies
  ASoC: samsung: add missing __devexit_p() annotations

 sound/soc/codecs/Kconfig  |    2 +-
 sound/soc/codecs/wm8782.c |    2 +-
 sound/soc/imx/Kconfig     |    1 +
 sound/soc/samsung/Kconfig |    4 ++++
 sound/soc/samsung/ac97.c  |    2 +-
 sound/soc/samsung/i2s.c   |    2 +-
 sound/soc/sh/fsi.c        |   10 +++++-----
 7 files changed, 14 insertions(+), 9 deletions(-)

-- 
1.7.5.4
