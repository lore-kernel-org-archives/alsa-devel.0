From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v3 0/3] Add I2S driver
Date: Thu, 11 May 2017 11:45:01 +0200
Message-ID: <1494495904-18898-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1389D266F03
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 11:45:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set handles the SPI/I2S IP on STM32 platforms.

It applies to STM32 platforms implementing version 2 of SPI/I2S IP like STM32H7 series.

The SPI/I2S block is a serial peripheral interface (SPI), which can also be configured to work on I2S/PCM mode.
ASoC STM32 I2S driver only supports this I2S/PCM mode.

The I2S/PCM interface can either support full duplex or half-duplex communication
(transmitter or receiver only). The change of mode requires to stop the interface.
This means that the two audio paths cannot be basically managed independently.

The driver supports playback and capture through a single bidirectionnal DAI. 
In the first version of the driver, playback and capture paths are made mutually exclusive.

A second patch introduces support of full duplex mode. 
In this implementation the interface is systematically configured in full-duplex mode
from hardware point of view. So, when managing a single audio path, the interface
is not configured as transmit or receive only, as it should be.
This restriction is handled by masking underrun/overrun errors from the unused path.

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

v2 -> v3
	- fix spinlock handling

olivier moysan (3):
  dt-bindings: Document STM32 I2S bindings
  ASoC: stm32: Add I2S driver
  ASoC: stm32: Add full duplex support to i2s

 .../devicetree/bindings/sound/st,stm32-i2s.txt     |  68 ++
 sound/soc/stm/Kconfig                              |   2 +-
 sound/soc/stm/Makefile                             |   4 +
 sound/soc/stm/stm32_i2s.c                          | 946 +++++++++++++++++++++
 4 files changed, 1019 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
 create mode 100644 sound/soc/stm/stm32_i2s.c

-- 
1.9.1
