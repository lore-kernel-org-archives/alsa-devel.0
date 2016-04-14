From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: [RFC PATCH v2 0/5] ASoC: Mediatek: Add support for
	MT2701 SOC
Date: Thu, 14 Apr 2016 20:14:25 +0800
Message-ID: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 38876261B0A
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 14:14:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Refactor and go v2 because of the 60KB limitation

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

The interface to connect with BT chip is not finished yet, but as an upstream
rookie I really need some comments. Any comments will be greatly appreciated.


Garlic Tseng (5):
  ASoC: mediatek: Refine mt8173 driver
  ASoC: mediatek: add documents for mt2701
  ASoC: mediatek: add clock and irq control for 2701 platform driver
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   39 +
 .../devicetree/bindings/sound/mtk2701-afe-pcm.txt  |  150 ++
 sound/soc/mediatek/Kconfig                         |   21 +
 sound/soc/mediatek/Makefile                        |   15 +-
 sound/soc/mediatek/mt2701/Makefile                 |   20 +
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  376 +++++
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c |  259 +++
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h |   28 +
 sound/soc/mediatek/mt2701/mtk2701-afe-common.h     |  217 +++
 sound/soc/mediatek/mt2701/mtk2701-afe-pcm.c        | 1752 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mtk2701-irq.c            |  109 ++
 sound/soc/mediatek/mt2701/mtk2701-irq.h            |   30 +
 sound/soc/mediatek/mt2701/mtk2701-reg.h            |  165 ++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |    2 +-
 sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h   |    0
 sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c      |    0
 20 files changed, 3186 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h (100%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c (100%)

-- 
1.9.1
