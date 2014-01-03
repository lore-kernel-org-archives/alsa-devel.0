From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v3 0/5] ASoC: add CSR SiRFSoC sound drivers
Date: Fri,  3 Jan 2014 14:04:59 +0800
Message-ID: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EDB226179B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 07:06:21 +0100 (CET)
Received: by mail-pd0-f180.google.com with SMTP id q10so14996800pdj.39
 for <alsa-devel@alsa-project.org>; Thu, 02 Jan 2014 22:06:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, Workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

This patchset adds CSR SiRFSoC sound drivers including:
1. the platform DMA driver which will be shard by all DAI
2. the I2S CPU DAI driver
3. the USP-based PCM CPU DAI driver
4. CPU DAI and Codec driver for internal chip codec
5. the mach driver for EVB board using internal codec

-v3: 
1. Use devm_* API for driver
2. Remove the extcon stuff code
3. Calculated automatically the div vaule at runtime based on the sample rate
4. Automatically discovering the configuration of pcm hardware from the dmaengine driver
5. Add binding documents

Rongjun Ying (5):
  ASoC: sirf: add sirf platform driver which provides DMA
  ASoC: sirf: add I2S CPU DAI driver
  ASoC: usp-pcm: add CPU DAI driver for PCM simulated from USP
  ASoC: sirf-soc-inner: add drivers for both CPU and Codec DAIs
  ASoC: sirf-inner: add mach driver for SiRFSoC internal codec

 .../bindings/sound/sirf,inner-audio-codec.txt      |   41 ++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/sirf/Kconfig                             |   18 +
 sound/soc/sirf/Makefile                            |   11 +
 sound/soc/sirf/sirf-audio.h                        |  268 ++++++++
 sound/soc/sirf/sirf-i2s.c                          |  435 +++++++++++++
 sound/soc/sirf/sirf-inner.c                        |  155 +++++
 sound/soc/sirf/sirf-pcm.c                          |   68 ++
 sound/soc/sirf/sirf-soc-inner.c                    |  653 ++++++++++++++++++++
 sound/soc/sirf/sirf-usp.c                          |  463 ++++++++++++++
 sound/soc/sirf/sirf-usp.h                          |  276 +++++++++
 12 files changed, 2390 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf,inner-audio-codec.txt
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio.h
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-inner.c
 create mode 100644 sound/soc/sirf/sirf-pcm.c
 create mode 100644 sound/soc/sirf/sirf-soc-inner.c
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

-- 
1.7.5.4
