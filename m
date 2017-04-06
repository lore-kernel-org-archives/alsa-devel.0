From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: Add I2S driver
Date: Thu, 6 Apr 2017 17:40:34 +0200
Message-ID: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3885526680F
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 17:40:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set handles the SPI/I2S IP on STM32 platforms.

It applies to STM32 platforms implementing version 2 of SPI/I2S IP like STM32H7 series.

The SPI/I2S block is a serial peripheral interface (SPI), 
which can also be configured to work on I2S/PCM mode.
ASoC STM32 I2S driver only supports this I2S/PCM mode.

The I2S/PCM interface can either support full duplex or half-duplex communication
(transmitter or receiver only).

I2S driver exhibits 3 DAIs corresponding to a playback, capture or full duplex PCM device.
When the interface is configured as full duplex, the related PCM device must be opened twice. 
The PCM streams are started when both playback and capture devices are opened.
The relevant DAI can be selected through Device Tree using sound-dai-cells parameter.

The I2S/PCM interface supports four audio standards:
I2S Philips standard, MSB justified standard, LSB justified standard, PCM standard
PCM standard is declined in two versions, PCM short and long,
according frame synchronization duration.

These standards can be mapped to ASoC standards as follows:
	- I2S: i2s
	- MSB justified standard: left_j
	- LSB justified standard: right_j
	- PCM short: dsp_a
PCM long format is not exposed as it does not match supported ASoC standards.

olivier moysan (2):
  dt-bindings: Document STM32 I2S bindings
  ASoC: stm32: Add I2S driver

 .../devicetree/bindings/sound/st,stm32h7-i2s.txt   |   71 ++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/stm/Kconfig                              |    8 +
 sound/soc/stm/Makefile                             |    2 +
 sound/soc/stm/stm32_i2s.c                          | 1069 ++++++++++++++++++++
 6 files changed, 1152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_i2s.c

-- 
1.9.1
