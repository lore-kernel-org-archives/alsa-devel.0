From: Koro Chen <koro.chen@mediatek.com>
Subject: ASoC: Mediatek: Add support for MT8173 SOC
Date: Fri, 10 Apr 2015 15:10:55 +0800
Message-ID: <1428649857-19415-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E0E42605D7
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 09:13:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: devicetree@vger.kernel.org, koro.chen@mediatek.com, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, galak@codeaurora.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This adds basic support for the Mediatek AFE unit for MT8173 SoC.
This patch is based on Linux 4.0-rc1, Sascha's clk patch [1], 
and his SCPSYS power patch [2].

The AFE unit comprises several memory interfaces that communicate with CPU,
a multi input multi output digital audio interconnect, and several external
interfaces (e.g. I2S). 

The AFE unit is a DMA master, so no external DMA engine is needed.

Each external interface is presented as a DAI to ASoC. A memory interface 
must be connected via the interconnect to an external interface. 
The connection pathes are configured through the device tree.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000079.html
[2] http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000132.html

Koro Chen (2):
  ASoC: mediatek: Add binding support for AFE driver
  ASoC: mediatek: Add AFE platform driver

 .../devicetree/bindings/sound/mtk-afe-pcm.txt      |  105 ++
 include/dt-bindings/sound/mtk-afe.h                |   36 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/mediatek/Kconfig                         |    8 +
 sound/soc/mediatek/Makefile                        |    2 +
 sound/soc/mediatek/mtk-afe-common.h                |  105 ++
 sound/soc/mediatek/mtk-afe-connection.c            |  416 ++++++
 sound/soc/mediatek/mtk-afe-connection.h            |   30 +
 sound/soc/mediatek/mtk-afe-pcm.c                   | 1497 ++++++++++++++++++++
 10 files changed, 2201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt
 create mode 100644 include/dt-bindings/sound/mtk-afe.h
 create mode 100644 sound/soc/mediatek/Kconfig
 create mode 100644 sound/soc/mediatek/Makefile
 create mode 100644 sound/soc/mediatek/mtk-afe-common.h
 create mode 100644 sound/soc/mediatek/mtk-afe-connection.c
 create mode 100644 sound/soc/mediatek/mtk-afe-connection.h
 create mode 100644 sound/soc/mediatek/mtk-afe-pcm.c

--
