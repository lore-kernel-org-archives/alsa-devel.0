From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 0/9]  asoc: Add audio for sti platforms
Date: Mon, 22 Jun 2015 16:31:04 +0200
Message-ID: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C1F265074
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 16:31:28 +0200 (CEST)
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

version 3 : 
	- patch dependency:
           ASoC: simple card: set cpu-dai sysclk with mclk-fs (Arnaud Pouliquen)
           
	- Remark not applied:
              Use Russell King's patch "sound/core: add IEC958 channel status helper".
              => This allows to create settings based on runtime, but not compatible with
                   iec958 controls exposed to userland (settings overwritten by  
                   snd_pcm_create_iec958_consumer)
	- main corrections:
        	- rework DAI CPU declaration to use generic dma
                - Supress abstraction layer for uniperiph player/reader
                - use dapm for DAC powerup/down
        
version 2: corrections after first review
	- bindings:
		. suppress useless dts declaration

	- uniperif_player.c:
		. Suppress standby mode in uniplayer ( will be part of a dedicated patch)
		. Deliver IEC and clock adjustement controls in separate patch
	- uniperif_reader.c:
		. kept as separate file as behavior and feature not same than uniplayer
		. minor corrections
	- codec/sti-sas.c
		. implement DAPM for DAC
		. rework registers declaration to separate device and driver part

version 1:
	- First patches submission

Arnaud Pouliquen (9):
  ASoC: sti: add binding for ASoC driver
  ASoC: sti: Add uniperipheral header file
  ASoC: sti: Add CPU DAI driver for playback
  ASoC: sti: Add CPU DAI driver for capture
  ASoC: sti: Add uniperipheral dai driver
  ASoC: Add ability to build sti drivers
  ASoC: Codec: Add sti platform codec
  ASoC: sti: Add clock adjustement control
  ASoC: sti: Add IEC control

 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  155 +++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sti-sas.c                         |  627 ++++++++++
 sound/soc/sti/Kconfig                              |   11 +
 sound/soc/sti/Makefile                             |    4 +
 sound/soc/sti/sti_uniperif.c                       |  254 ++++
 sound/soc/sti/uniperif.h                           | 1229 ++++++++++++++++++++
 sound/soc/sti/uniperif_player.c                    | 1109 ++++++++++++++++++
 sound/soc/sti/uniperif_reader.c                    |  364 ++++++
 12 files changed, 3762 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
 create mode 100644 sound/soc/codecs/sti-sas.c
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile
 create mode 100644 sound/soc/sti/sti_uniperif.c
 create mode 100644 sound/soc/sti/uniperif.h
 create mode 100644 sound/soc/sti/uniperif_player.c
 create mode 100644 sound/soc/sti/uniperif_reader.c

-- 
1.9.1
