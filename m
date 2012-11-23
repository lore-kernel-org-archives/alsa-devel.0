From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [GIT PULL] ASoC: Samsung: Updates for v3.8
Date: Fri, 23 Nov 2012 18:27:19 +0900
Message-ID: <000001cdc95c$c1d7ec20$4587c460$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B572261691
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 10:27:46 +0100 (CET)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDX00EYDOXG83K0@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 23 Nov 2012 18:27:26 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDX00BMYOXH0C00@mmp1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 23 Nov 2012 18:27:26 +0900 (KST)
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, 'Sangsu Park' <sangsu4u.park@samsung.com>, 'Padmavathi Venna' <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

It's Samsung audio updates which are mainly device tree supports.
We had fully tested on SMDK5250.

Thanks,
Sangbeom.

---------

The following changes since commit 208229ecb95b58a627d2f01fc4e2a1652c27f4d9:

  ASoC: bells: Up to 512fs (2012-11-16 17:42:40 -0800)

(sound.git topic/samsung)

are available in the git repository at:

git://github.com/cornus/linux-samsung.git  for-broonie

----------------------------------------------------------------
Padmavathi Venna (2):
      ASoC: SAMSUNG: Add DT support for i2s
      ASoC: Samsung: Register the audio dma platform device
Sachin Kamat (1):
      ASoC: Samsung-dma: Fix potential NULL pointer dereference
Sangsu Park (1):
      ASoC: Samsung: Update Kconfig for I2S,SPDIF and PCM audio

 .../devicetree/bindings/sound/samsung-i2s.txt      |   69 ++++++
 sound/soc/samsung/Kconfig                          |    6 +-
 sound/soc/samsung/dma.c                            |   44 ++++-
 sound/soc/samsung/dma.h                            |    1 +
 sound/soc/samsung/i2s.c                            |  234 ++++++++++++++++----
 5 files changed, 298 insertions(+), 56 deletions(-)
