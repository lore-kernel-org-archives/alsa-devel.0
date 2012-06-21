From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 0/9] Add ASoC drivers for SPEAr platform &
	I2S driver for Designware module
Date: Thu, 21 Jun 2012 15:54:48 +0530
Message-ID: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DDE6510B96C
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:03:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Changes since V1:
1. Move Synopsys i2s designware controller from 'spear' folder to a new folder 'dwc' 
2. Implemented regmap in sta529 codec.
3. In-corporated review comments received on V1.

Rajeev Kumar (6):
  sound:asoc: Add support for STA529 Audio Codec
  sound:asoc: Add support for synopsys i2s controller as per ASoC
    framework.
  sound:asoc: Add support for SPEAr ASoC pcm layer.
  sound:asoc: Add support for SPEAr ASoC machine driver.
  sound:asoc: Add Kconfig and Makefile to support SPEAr audio driver
  sound:asoc: Update Kconfig and Makefile(sound/soc/) to support SPEAr
    audio

Vipin Kumar (3):
  sound:asoc: Add support for spdif in Audio Codec
  sound:asoc:spdif_in: Add spdif IN support
  sound:asoc:spdif_out: Add spdif out support

 include/sound/designware_i2s.h    |   69 ++++++
 include/sound/spear_dma.h         |   35 +++
 include/sound/spear_spdif.h       |   29 +++
 sound/soc/Kconfig                 |    2 +
 sound/soc/Makefile                |    2 +
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    4 +-
 sound/soc/codecs/spdif_receiver.c |   76 ++++++
 sound/soc/codecs/sta529.c         |  477 +++++++++++++++++++++++++++++++++++++
 sound/soc/dwc/Kconfig             |    8 +
 sound/soc/dwc/Makefile            |    3 +
 sound/soc/dwc/designware_i2s.c    |  454 +++++++++++++++++++++++++++++++++++
 sound/soc/spear/Kconfig           |   40 +++
 sound/soc/spear/Makefile          |    7 +
 sound/soc/spear/spdif_in.c        |  297 +++++++++++++++++++++++
 sound/soc/spear/spdif_in_regs.h   |   60 +++++
 sound/soc/spear/spdif_out.c       |  397 ++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_out_regs.h  |   79 ++++++
 sound/soc/spear/spear_evb.c       |  206 ++++++++++++++++
 sound/soc/spear/spear_pcm.c       |  214 +++++++++++++++++
 20 files changed, 2462 insertions(+), 1 deletions(-)
 create mode 100644 include/sound/designware_i2s.h
 create mode 100644 include/sound/spear_dma.h
 create mode 100644 include/sound/spear_spdif.h
 create mode 100644 sound/soc/codecs/spdif_receiver.c
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/dwc/Kconfig
 create mode 100644 sound/soc/dwc/Makefile
 create mode 100644 sound/soc/dwc/designware_i2s.c
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/spear/spdif_in.c
 create mode 100644 sound/soc/spear/spdif_in_regs.h
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h
 create mode 100644 sound/soc/spear/spear_evb.c
 create mode 100644 sound/soc/spear/spear_pcm.c
