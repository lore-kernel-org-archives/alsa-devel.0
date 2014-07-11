From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] ASoC: samsung updates from arm testing
Date: Fri, 11 Jul 2014 15:45:03 +0200
Message-ID: <1405086308-1461192-2-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: t.figa@samsung.com, broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Here are a few patches from my randconfig and multiplatform series.
The smartq patch is a re-send of the one I screwed up the other day.
the dependencies and dma data removal should be trivial, the
dmaengine one probably needs some closer inspection.

	Arnd

Arnd Bergmann (4):
  ASoC: samsung: add explicit i2c/spi dependencies
  ASoC: samsung/smartq: use dynamic registration
  ASoC: samsung: s3c24xx dmaengine follow-up
  ASoC: samsung: remove unused DMA data

 arch/arm/mach-s3c64xx/mach-smartq.c           | 10 ++++
 include/linux/platform_data/asoc-s3c-smartq.h | 10 ++++
 sound/soc/samsung/Kconfig                     | 18 +++----
 sound/soc/samsung/Makefile                    |  2 +-
 sound/soc/samsung/ac97.c                      | 32 ------------
 sound/soc/samsung/dma.h                       |  7 ---
 sound/soc/samsung/i2s.c                       |  6 ---
 sound/soc/samsung/pcm.c                       | 12 -----
 sound/soc/samsung/s3c-i2s-v2.c                |  2 -
 sound/soc/samsung/s3c2412-i2s.c               |  4 --
 sound/soc/samsung/s3c24xx-i2s.c               |  4 --
 sound/soc/samsung/smartq_wm8987.c             | 73 ++++++++++-----------------
 sound/soc/samsung/spdif.c                     |  5 --
 13 files changed, 54 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/platform_data/asoc-s3c-smartq.h

-- 
1.8.3.2
