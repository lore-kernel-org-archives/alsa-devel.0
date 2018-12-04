From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/7] ASoC: merge simple-scu-card into
	simple-card - step1
Date: Tue, 4 Dec 2018 08:19:08 +0000
Message-ID: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400092.outbound.protection.outlook.com [40.107.140.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 66EC426789B
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:19:11 +0100 (CET)
Content-Language: en-US
Content-ID: <D53052BA09DEC448BC87FC9B2AADD326@jpnprd01.prod.outlook.com>
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

I'm posting "merge audio-graph-card" patch-set now.
And, I decided to samethings to "simple-card".
These are prepare for merging.

Kuninori Morimoto (7):
  ASoC: simple-card: use cpu/codec pointer on simple_dai_props
  ASoC: simple-scu-card: tidyup asoc_simple_card_parse_daifmt() timing
  ASoC: simple-scu-card: add dai-link support
  ASoC: simple-scu-card: care link / dai count
  ASoC: simple-scu-card: tidyup "convert-rate/channels" parsing
  ASoC: simple-scu-card: use cpu/codec pointer on graph_dai_props
  ASoC: simple-scu-card: care multi DPCM codec_conf

 sound/soc/generic/simple-card.c     |  62 +++++----
 sound/soc/generic/simple-scu-card.c | 261 +++++++++++++++++++++++++++---------
 2 files changed, 235 insertions(+), 88 deletions(-)

-- 
2.7.4
