From: Sean Cross <xobs@kosagi.com>
Subject: [PATCH v2 0/3] Add ES8328 audio codec
Date: Tue, 17 Jun 2014 13:16:26 +0800
Message-ID: <1402982189-28598-1-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.g1.pair.com (mail1.g1.pair.com [66.39.3.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 372D8265518
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 07:16:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Nicolin Chen <Guangyu.Chen@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Everest Semi ES8328 audio codec.  It also
adds support for using the es8328 on IMX boards.

We write a machine driver rather than using simple-card because the machine
driver needs to support regulators for the codec itself and speaker amps,
have headphone support, and must supply an unusual frequency to the codec chip.

Changes since v1:

    - Rename HP/Speaker to OUT1/OUT2
    - Use DAPM widgets for startup/shutdown
    - Add regulator support to machine driver

Sean Cross (3):
  devicetree: bindings: Add Everest Semicodunctor
  ASoC: add es8328 codec driver
  ASoC: fsl: add imx-es8328 machine driver

 Documentation/devicetree/bindings/sound/es8328.txt |  18 +
 .../devicetree/bindings/sound/imx-audio-es8328.txt |  60 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es8328.c                          | 711 +++++++++++++++++++++
 sound/soc/codecs/es8328.h                          | 305 +++++++++
 sound/soc/fsl/Kconfig                              |  13 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/imx-es8328.c                         | 359 +++++++++++
 10 files changed, 1476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h
 create mode 100644 sound/soc/fsl/imx-es8328.c

-- 
2.0.0
