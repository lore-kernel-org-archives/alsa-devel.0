From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 00/10] ASoC: merge audio-graph-scu into
	audio-graph - step2
Date: Thu, 22 Nov 2018 00:54:25 +0000
Message-ID: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410090.outbound.protection.outlook.com [40.107.141.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CCA326770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:54:29 +0100 (CET)
Content-Language: en-US
Content-ID: <43687D033B00AE49A9F3A078B588C100@jpnprd01.prod.outlook.com>
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

So, this is the time to merge audio-graph and audio-graph-scu.
The patch-set are a little bit huge (and few patches are depend
on posted OF patch. I'm now waiting...),
thus, I separated these into few steps.

These are step2 patches

Kuninori Morimoto (10):
  ASoC: soc-core: add snd_soc_of_parse_node_prefix()
  ASoC: simple-scu-card: tidyup "prefix" parsing on Doc
  ASoC: simple-scu-card: tidyup "prefix" parsing
  ASoC: audio-graph-scu-card: tidyup "prefix" parsing on Doc
  ASoC: audio-graph-scu-card: tidyup "prefix" parsing
  ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing on Doc
  ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing
  ASoC: audio-graph-scu-card: tidyup asoc_simple_card_parse_daifmt() timing
  ASoC: audio-graph-card: tidyup typo SND_AUDIO_GRAPH_CARD
  ASoC: audio-graph-card: tidyup define position

 .../bindings/sound/audio-graph-scu-card.txt        |  4 +-
 .../devicetree/bindings/sound/simple-scu-card.txt  |  2 +-
 include/sound/soc.h                                |  6 +-
 sound/soc/generic/Kconfig                          |  2 +-
 sound/soc/generic/audio-graph-card.c               | 10 +--
 sound/soc/generic/audio-graph-scu-card.c           | 71 ++++++++++------------
 sound/soc/generic/simple-scu-card.c                |  7 +++
 sound/soc/soc-core.c                               | 11 ++--
 8 files changed, 59 insertions(+), 54 deletions(-)

-- 
2.7.4
