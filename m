From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v5 0/7] ASoC: add CSR SiRFSoC sound drivers
Date: Wed,  5 Mar 2014 10:36:20 +0800
Message-ID: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D459F26583C
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 03:37:00 +0100 (CET)
Received: by mail-pb0-f54.google.com with SMTP id ma3so409658pbc.41
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 18:36:59 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

This patchset adds CSR SiRFSoC sound drivers including:
1. The SiRF internal audio codec driver
2. The SiRF audio port driver
3. The SiRF internal audio card driver
4. The SiRF I2S controller driver
5. The SiRF hdmi card driver
6. The SiRF USP controller(DSP mode) driver
7. The SiRF bt-sco card driver

-v5:
1. Drop all inlines.
2. Reordering the Kconfig and Makefile
3. Remove the sirf_audio_codec_reg_bits struct, use the new controls instead it.
4. Add some SND_SOC_DAPM_OUT_DRV instead of HP and SPK enable driver
5. Add audio codec clock supply instead of adc event callback
6. Fixed playback and capture can't concurrent work bug.

Rongjun Ying (7):
  ASoC: sirf: Add SiRF internal audio codec driver
  ASoC: sirf: Add SiRF audio port driver is used by SiRF internal audio
    codec
  ASoC: sirf: Add SiRF audio card
  ASoC: sirf: Add SiRF I2S driver
  ASoC: sirf: Add hdmi card
  ASoC: sirf: Add usp driver which is used by dsp mode
  ASoC: sirf: Add bt-sco card

 .../devicetree/bindings/sound/sirf-audio-codec.txt |   17 +
 .../devicetree/bindings/sound/sirf-audio-port.txt  |   20 +
 .../devicetree/bindings/sound/sirf-audio.txt       |   41 ++
 .../devicetree/bindings/sound/sirf-bt-sco.txt      |   18 +
 .../devicetree/bindings/sound/sirf-hdmi.txt        |   15 +
 .../devicetree/bindings/sound/sirf-i2s.txt         |   27 +
 .../devicetree/bindings/sound/sirf-usp.txt         |   27 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |    6 +-
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sirf-audio-codec.c                |  534 ++++++++++++++++++++
 sound/soc/codecs/sirf-audio-codec.h                |   75 +++
 sound/soc/sirf/Kconfig                             |   34 ++
 sound/soc/sirf/Makefile                            |   13 +
 sound/soc/sirf/sirf-audio-port.c                   |  194 +++++++
 sound/soc/sirf/sirf-audio-port.h                   |   62 +++
 sound/soc/sirf/sirf-audio.c                        |  156 ++++++
 sound/soc/sirf/sirf-bt-sco.c                       |   99 ++++
 sound/soc/sirf/sirf-hdmi.c                         |   98 ++++
 sound/soc/sirf/sirf-i2s.c                          |  434 ++++++++++++++++
 sound/soc/sirf/sirf-i2s.h                          |   88 ++++
 sound/soc/sirf/sirf-usp.c                          |  448 ++++++++++++++++
 sound/soc/sirf/sirf-usp.h                          |  282 +++++++++++
 24 files changed, 2691 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-port.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-bt-sco.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-usp.txt
 create mode 100644 sound/soc/codecs/sirf-audio-codec.c
 create mode 100644 sound/soc/codecs/sirf-audio-codec.h
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio-port.c
 create mode 100644 sound/soc/sirf/sirf-audio-port.h
 create mode 100644 sound/soc/sirf/sirf-audio.c
 create mode 100644 sound/soc/sirf/sirf-bt-sco.c
 create mode 100644 sound/soc/sirf/sirf-hdmi.c
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-i2s.h
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

-- 
1.7.5.4
