From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/4] ASoC: merge audio-graph-scu into
	audio-graph - step3
Date: Mon, 26 Nov 2018 04:58:39 +0000
Message-ID: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410123.outbound.protection.outlook.com [40.107.141.123])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D8E2679A7
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 05:58:43 +0100 (CET)
Content-Language: en-US
Content-ID: <998AD49CCA27A94DBA8715356278EA1C@jpnprd01.prod.outlook.com>
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

This is step3 patches.

After step3, the remaining patch is "merge audio-graph and audio-graph-scu"
and "remove audio-graph-scu" patches,
and, +1 more patch which is based on OF graph patches.
I'm posting it to OF ML, but no response so far.
Thus, step4 patch will be *after* OF graph patch.

Kuninori Morimoto (4):
  ASoC: audio-graph-scu-card: care link / dai count
  ASoC: audio-graph-scu-card: use cpu/codec pointer on graph_dai_props
  ASoC: audio-graph-scu-card: care multi DPCM codec_conf
  ASoC: audio-graph-card: use cpu/codec pointer on graph_dai_props

 sound/soc/generic/audio-graph-card.c     |  57 ++++++-----
 sound/soc/generic/audio-graph-scu-card.c | 163 ++++++++++++++++++++++---------
 2 files changed, 153 insertions(+), 67 deletions(-)

-- 
2.7.4
