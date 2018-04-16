From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2 0/5] ASoC: mediatek: add support for mt6797
	SoC
Date: Mon, 16 Apr 2018 08:32:47 +0800
Message-ID: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A244267217
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 02:33:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

This patch adds basic support for Mediatek AFE for MT6797 SoC.

Change since the previous patch set:
* fix build warning in sound/soc/codecs/mt6351.c

KaiChieh Chuang (5):
  ASoC: add mt6351 codec driver
  ASoC: mt6797: add structure define and clock control function for 6797
  ASoC: mt6797: add mt6797 platform driver
  ASoC: add mt6797-mt6351 driver and config option
  ASoC: mediatek: add documents for mt6797

 Documentation/devicetree/bindings/sound/mt6351.txt |   16 +
 .../devicetree/bindings/sound/mt6797-afe-pcm.txt   |   42 +
 .../devicetree/bindings/sound/mt6797-mt6351.txt    |   14 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6351.c                          | 1639 ++++++++++++++++++++
 sound/soc/codecs/mt6351.h                          |  108 ++
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt6797/Makefile                 |   19 +
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         |  132 ++
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h         |   25 +
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      |   57 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 1234 +++++++++++++++
 sound/soc/mediatek/mt6797/mt6797-interconnection.h |   41 +
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          |  186 +++
 sound/soc/mediatek/mt6797/mt6797-reg.h             |  846 ++++++++++
 17 files changed, 4386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6351.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-mt6351.txt
 create mode 100644 sound/soc/codecs/mt6351.c
 create mode 100644 sound/soc/codecs/mt6351.h
 create mode 100644 sound/soc/mediatek/mt6797/Makefile
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-common.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-interconnection.h
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-mt6351.c
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-reg.h

-- 
2.12.5
