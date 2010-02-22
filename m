From: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Subject: [PATCH v4 0/3] McPDM driver patch series
Date: Mon, 22 Feb 2010 15:09:15 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8FA52A10@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 96ACC10385C
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 22:09:19 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

McPDM module is the interface between the OMAP and TWL6030 audio codec.

The interface supports the following:
* Up to 5 downlink channels and 3 uplink channels
* 88.2 and 96 KHz
* 32 bit sample size

Currently, driver is set to support up to 4 downlink channels. If 2
channels are selected, output will go to the headset, and if 4 channels
are selected, output will go to the headset and speakers. Functionality
to select the output at runtime will be added afterwards.

Command and status mode is not supported in current patches.

Changes from v3:
- Implemented changes based on comments from Liam Girdwood.

--

Jorge Eduardo Candelaria (1):
      ASoC: OMAP4: Add support for McPDM

Misael Lopez Cruz (2):
      ASoC: OMAP: data_type and sync_mode configurable in audio dma
      ASoC: OMAP4: Add McPDM platform driver

 sound/soc/omap/Kconfig      |    3 +
 sound/soc/omap/Makefile     |    2 +
 sound/soc/omap/mcpdm.c      |  486 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/mcpdm.h      |  151 +++++++++++++
 sound/soc/omap/omap-mcbsp.c |    2 +
 sound/soc/omap/omap-mcpdm.c |  251 ++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   29 +++
 sound/soc/omap/omap-pcm.c   |   15 +-
 sound/soc/omap/omap-pcm.h   |    4 +-
 9 files changed, 935 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/omap/mcpdm.c
 create mode 100644 sound/soc/omap/mcpdm.h
 create mode 100644 sound/soc/omap/omap-mcpdm.c
 create mode 100644 sound/soc/omap/omap-mcpdm.h
