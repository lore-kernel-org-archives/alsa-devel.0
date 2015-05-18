From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 0/9] asoc: Add audio for sti platforms
Date: Mon, 18 May 2015 14:12:47 +0200
Message-ID: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 4CE1626109C
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 14:15:41 +0200 (CEST)
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

version 2: corrections after first review
	- bindings:
		. suppress useless dts declarations

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
  ASoC: sti: add binding for ASoc driver
  ASoC: sti: Add uniperipheral header file
  ASoC: sti: Add CPU DAI driver for playback
  ASoC: sti: Add CPU DAI driver for capture
  ASoC: sti: Add platform driver
  ASoC: Add ability to build sti drivers
  ASoC: Codec: Add sti platform codec
  ASoC: sti: Add clock adjustement control
  ASoC: sti: Add IEC control

 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  158 +++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sti-sas.c                         |  645 +++++++++++
 sound/soc/sti/Kconfig                              |   17 +
 sound/soc/sti/Makefile                             |    5 +
 sound/soc/sti/sti_platform.c                       |  642 ++++++++++
 sound/soc/sti/uniperif.h                           | 1224 ++++++++++++++++++++
 sound/soc/sti/uniperif_player.c                    | 1218 +++++++++++++++++++
 sound/soc/sti/uniperif_reader.c                    |  459 ++++++++
 12 files changed, 4376 insertions(+)
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
