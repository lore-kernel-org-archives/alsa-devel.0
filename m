From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/6] ASoC: merge audio-graph-scu into
	audio-graph - final step
Date: Wed, 5 Dec 2018 01:29:37 +0000
Message-ID: <871s6wepmp.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400114.outbound.protection.outlook.com [40.107.140.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 125CB267B88
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 02:29:44 +0100 (CET)
Content-Language: en-US
Content-ID: <D65EB83D1C46A74F80A44F86811113D1@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Mark

audio-graph     card can handle normal sound card, and
audio-graph-scu card can handle DPCM   sound card.
But, we can't use these feature in same time now.

This is final step patches.

Kuninori Morimoto (6):
  ASoC: audio-graph-card: merge audio-graph-scu-card on Doc
  ASoC: audio-graph-card: merge audio-graph-scu-card
  ASoC: audio-graph-card: tidyup mclk-fs method
  ASoC: audio-graph-card: tidyup convert_rate/channel method
  ASoC: audio-graph-scu-card: remove audio-graph-scu-card on Doc
  ASoC: audio-graph-scu-card: remove audio-graph-scu-card

 .../devicetree/bindings/sound/audio-graph-card.txt | 222 +++++++++
 .../bindings/sound/audio-graph-scu-card.txt        | 123 -----
 sound/soc/generic/Kconfig                          |  10 +-
 sound/soc/generic/Makefile                         |   2 -
 sound/soc/generic/audio-graph-card.c               | 397 +++++++++++++---
 sound/soc/generic/audio-graph-scu-card.c           | 501 ---------------------
 6 files changed, 563 insertions(+), 692 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
 delete mode 100644 sound/soc/generic/audio-graph-scu-card.c

-- 
2.7.4
