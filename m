From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: [PATCH 0/4] ASoC: Mediatek: add MT2701 platform and
	machine driver
Date: Mon, 4 Jul 2016 18:56:24 +0800
Message-ID: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4C9265611
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 12:56:38 +0200 (CEST)
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

Some patches of the patchset "ASoC: Mediatek: Add support for MT2701 SOC"
have been applied to the broonie tree, so I send a new patchset for the 
remaining patches.

The patchset adds mt2701 support based on Mediatek AFE common structure.

Change since the previous patchset:
* remove unnecessary set_clkdiv and set_fmt ops in mt2701 platform driver
* add another snd_soc_dai_driver for bt-sco codec to support 8k and 16k



Garlic Tseng (4):
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: bt-sco: extend rate and add a general compatible string
  ASoC: mediatek: add BT implementation
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 sound/soc/codecs/bt-sco.c                          |   52 +-
 sound/soc/mediatek/Kconfig                         |   21 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt2701/Makefile                 |   19 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |    9 -
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1654 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  412 +++++
 8 files changed, 2144 insertions(+), 26 deletions(-)
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c

-- 
1.9.1
