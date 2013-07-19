From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/6] ASoC: add CSR SiRFSoC sound drivers
Date: Fri, 19 Jul 2013 19:07:16 +0800
Message-ID: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id BDBC7265673
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 13:08:30 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so4256588pbc.23
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 04:08:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds CSR SiRFSoC sound drivers including:
1. the platform DMA driver which will be shard by all DAI
2. the I2S CPU DAI driver
3. the USP-based PCM CPU DAI driver
4. CPU DAI and Codec driver for internal chip codec
5. the mach driver for EVB board using internal codec

Barry Song (1):
  arm: prima2: defconfig: enable sound components

Rongjun Ying (5):
  ASoC: sirf: add sirf platform driver which provides DMA
  ASoC: sirf: add I2S CPU DAI driver
  ASoC: usp-pcm: add CPU DAI driver for PCM simulated from USP
  ASoC: sirf-soc-inner: add drivers for both CPU and Codec DAIs
  ASoC: sirf-inner: add mach driver for SiRFSoC internal codec

 arch/arm/configs/prima2_defconfig |  10 +-
 sound/soc/Kconfig                 |   1 +
 sound/soc/Makefile                |   1 +
 sound/soc/sirf/Kconfig            |  18 ++
 sound/soc/sirf/Makefile           |  11 +
 sound/soc/sirf/sirf-audio.h       | 266 ++++++++++++++++
 sound/soc/sirf/sirf-i2s.c         | 411 ++++++++++++++++++++++++
 sound/soc/sirf/sirf-inner.c       | 267 ++++++++++++++++
 sound/soc/sirf/sirf-pcm.c         | 221 +++++++++++++
 sound/soc/sirf/sirf-pcm.h         |  17 +
 sound/soc/sirf/sirf-soc-inner.c   | 653 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-usp.c         | 481 ++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-usp.h         | 276 ++++++++++++++++
 13 files changed, 2630 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio.h
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-inner.c
 create mode 100644 sound/soc/sirf/sirf-pcm.c
 create mode 100644 sound/soc/sirf/sirf-pcm.h
 create mode 100644 sound/soc/sirf/sirf-soc-inner.c
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

-- 
1.8.2.3
