From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/5 v2] ASoC: merge simple-scu-card into
	simple-card - step1
Date: Tue, 11 Dec 2018 03:24:32 +0000
Message-ID: <87bm5sbvq6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400124.outbound.protection.outlook.com [40.107.140.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 1095626770D
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 04:24:37 +0100 (CET)
Content-Language: en-US
Content-ID: <64AA0F7674300649A841E3332D700A09@jpnprd01.prod.outlook.com>
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

These are based on latest "for-4.21" branch.

Kuninori Morimoto (5):
  ASoC: simple-scu-card: add dai-link support
  ASoC: simple-scu-card: care link / dai count
  ASoC: simple-scu-card: tidyup "convert-rate/channels" parsing
  ASoC: simple-scu-card: use cpu/codec pointer on graph_dai_props
  ASoC: simple-scu-card: care multi DPCM codec_conf

 sound/soc/generic/simple-scu-card.c | 240 +++++++++++++++++++++++++++---------
 1 file changed, 185 insertions(+), 55 deletions(-)

-- 
2.7.4



Best regards
---
Kuninori Morimoto
