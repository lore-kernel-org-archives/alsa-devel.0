From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/5] max9867 driver update
Date: Fri, 23 Nov 2018 15:25:07 +0100
Message-ID: <20181123142507.GA7347@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E05142678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:25:08 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992971AbeKWOZIN9Dle (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Fri, 23 Nov 2018 15:25:08 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

this is yet another round of driver update. Tested on AT91SAM9G20
based board with codec in master mode. All implemeted controls do
work now.

Ladislav Michl (5):
  ASoC: max9867: Fix whitespace
  ASoC: max9867: Fix power management
  ASoC: max9867: Calculate LRCLK divider
  ASoC: max9867: Fix signal paths
  ASoC: max9867: Add copyright and module author

 sound/soc/codecs/max9867.c | 479 ++++++++++++++++++-------------------
 sound/soc/codecs/max9867.h |  41 ++--
 2 files changed, 247 insertions(+), 273 deletions(-)

-- 
2.19.1
