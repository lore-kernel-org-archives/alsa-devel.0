From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/4] ASoC: merge audio-graph-scu into
	audio-graph - step1
Date: Wed, 21 Nov 2018 02:08:20 +0000
Message-ID: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400113.outbound.protection.outlook.com [40.107.140.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 28730267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 03:08:25 +0100 (CET)
Content-Language: en-US
Content-ID: <30B8F9EA9E2FF5498FD73818DA1AC19C@jpnprd01.prod.outlook.com>
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

ex)
audio-graph can handle normal sound card

	CPU1 -- Codec1
	CPU2 -- Codec2

audio-graph-scu can handle DPCM sound card

	CPU1 --- Codec1
	CPU2 -/

But, we can't use these in same time

	CPU1 --- Codec1
	CPU2 --- Codec2
	CPU3 -/

So, this is the time to merge audio-graph and audio-graph-scu.
The patch-set are a little bit huge (and few patches are depend
on posted OF patch. I'm now waiting...),
thus, I separated these into few steps.
This is step1 as prepare merging.
I think it will be 4 or more steps.

"simple card" and "audio graph card" are similar sound card,
and now I'm focusing to "audio graph card" merging only.
Basically simple-card and simple-scu-card are similar too,
and we can merge it. But I have no plan for it now.
Please try it someone ;P

Kuninori Morimoto (4):
  ASoC: simple-card-utils: remove asoc_simple_card_clk_register()
  ASoC: simple-card-utils: accept NULL parameter on asoc_simple_card_xxx()
  ASoC: simple-card-utils: tidyup asoc_simple_card_parse_convert()
  ASoC: simple_card_utils: remove "option" from asoc_simple_card_of_parse_routing()

 include/sound/simple_card_utils.h        |  6 +++---
 sound/soc/generic/audio-graph-card.c     |  2 +-
 sound/soc/generic/audio-graph-scu-card.c |  4 ++--
 sound/soc/generic/simple-card-utils.c    | 34 +++++++++++++++-----------------
 sound/soc/generic/simple-card.c          |  2 +-
 sound/soc/generic/simple-scu-card.c      |  4 ++--
 6 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.7.4
