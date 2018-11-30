From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 0/5] ASoC: merge audio-graph-scu into
	audio-graph - step3
Date: Fri, 30 Nov 2018 02:02:43 +0000
Message-ID: <87zhtrz5yt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410124.outbound.protection.outlook.com [40.107.141.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 833F8267B85
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2018 03:02:48 +0100 (CET)
Content-Language: en-US
Content-ID: <54C06E6547ADE541BF275CAF51E24E99@jpnprd01.prod.outlook.com>
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

This is v2 of step3 patches.

I mentioned that step4 patch-set will be based on OF-graph
posted patch, but, I could solve it without posted patch.
There is no blocker anymore.
Thus, I included blocked patch on step3.

Kuninori Morimoto (5):
  ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting
  ASoC: audio-graph-scu-card: care link / dai count
  ASoC: audio-graph-scu-card: use cpu/codec pointer on graph_dai_props
  ASoC: audio-graph-scu-card: care multi DPCM codec_conf
  ASoC: audio-graph-card: use cpu/codec pointer on graph_dai_props

 sound/soc/generic/audio-graph-card.c     |  57 ++++++----
 sound/soc/generic/audio-graph-scu-card.c | 180 +++++++++++++++++++++++--------
 sound/soc/generic/simple-card-utils.c    |  22 +---
 3 files changed, 173 insertions(+), 86 deletions(-)

-- 
2.7.4
