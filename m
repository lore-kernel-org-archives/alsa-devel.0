From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/7] asoc: Add audio for sti platforms
Date: Tue, 14 Apr 2015 15:35:24 +0200
Message-ID: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 95E73260554
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

version 1:
	- First patches submission

Set of patches concerns the audio part of the STi platform

Hardware is split in two main blocks:
Unipheriperal IPs and codec IPs

Uniperipheral IPs:
Ips in charge of the I2S buses
Uniperipheral IPs are in charge the PCM rendering/capturing on/from I2S.
- 4 uniperipheral player IPs receive the PCM audio data or audio encoded
bit stream data from the memory (via FDMA)and performs optional IEC-60958 or
IEC-61937 formatting on the audio data and sends them out on the I2S output.
- 2 uniperipheral reader IPS receive the PCM audio or encoded bit stream on
the I2S input interface and writes the processed data in memory (via FDMA)

Codec IPs:
- HDMI_TX: format and generate HDMI signal.
- SPDIF: format and generate biphase signal for SPDIF output
- DAC: format and generate stereo analogic signal
- HDMI_RX: receive HDMI signal from external source.

In addition 2 I2S/TDM interfaces are available to connect external ICs
- PCM_IN to external capture codec (ADC, BT...)
- PCM_OUT for external player codec (DAC, BT..)

On Sti platform audio driver is splitted in 2 part to support Hw architecture
- sti_audio_platform for uniperipheral IPs mmannagement
- sti-sas codec for codec IP management

	+-----------------------+        +-----------------+
	|   +-----------------+ |        |                 |
	|   |    +---------+  | |        | +---------+     |
	|   |    |Uniperif |  | |        | |  HDMI   |     | +---+
	|   |    |player 0 +--------------->   TX    +------->   |
	|   |    +---------+  | |        | +---------+     | +---+
	|   |    +---------+  | |        |                 |
	|   |    |Uniperif |  | |        |                 | +---+
	|   |    |player 1 +--------------------------------->   |
	|   |    +---------+  | |        |                 | +---+
	|   |    +---------+  | |        | +---------+     | +---+
	|   |    |Uniperif |  | |        | |   DAC   |     | |   |
	|   |    |player 2 +--------------->         +------^----+
	|   |    +---------+  | |        | +---------+     |
	|   |    +---------+  | |        | +---------+     |
	|   |    |Uniperif |  | |        | |  SPDIF  |     | +---+
	|   |    |player 3 +--------------->         +------->   |
	|   |    +---------+  | |        | +---------+     | +---+
	|   |    +---------+  | |        |                 |
	|   |    |Uniperif |  | |        |                 | +---+
	|   |    |reader 0 <---------------------------------+   |
	|   |    +---------+  | |        |                 | +---+
	|   |    +---------+  | |        | +---------+     |
	|   |    |Uniperif |  | |        | |  HDMIF  |     | +---+
	|   |    |reader 1 <---------------+   RX    <-------+   |
	|   |    +---------+  | |        | +---------+     | +---+
	|   |                 | |        |                 |
	|   |     CPU DAI     | |        |                 |
	|   +-----------------+ |        |                 |
	|     STI platform      |        |    SAS CODEC    |
	+-----------------------+        +-----------------+

In the first version of the driver only SPDIF and DAC are supported.
in future HDMI TX, HDMI_RX and support for TDM mode should be added.

Arnaud Pouliquen (7):
  ASoC: sti: add binding for ASoc driver
  Asoc: sti: add uniperipheral header file
  Asoc: sti: add CPU DAI driver for playback
  Asoc: sti: add CPU DAI driver for capture
  Asoc: sti: Add platform driver
  ASoc: Add ability to build sti drivers
  ASoc: Codec: add sti platform codec

 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  176 +++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sti-sas.c                         |  663 ++++++++++
 sound/soc/sti/Kconfig                              |   17 +
 sound/soc/sti/Makefile                             |    5 +
 sound/soc/sti/sti_platform.c                       |  643 +++++++++
 sound/soc/sti/uniperif.h                           | 1236 ++++++++++++++++++
 sound/soc/sti/uniperif_player.c                    | 1367 ++++++++++++++++++++
 sound/soc/sti/uniperif_reader.c                    |  493 +++++++
 12 files changed, 4608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
 create mode 100644 sound/soc/codecs/sti-sas.c
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile
 create mode 100644 sound/soc/sti/sti_platform.c
 create mode 100644 sound/soc/sti/uniperif.h
 create mode 100644 sound/soc/sti/uniperif_player.c
 create mode 100644 sound/soc/sti/uniperif_reader.c

-- 
1.9.1
