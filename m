From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/6] ASoC: max9867: Driver update
Date: Thu, 1 Mar 2018 15:18:43 +0100
Message-ID: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 645AA267924
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:18:47 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993890AbeCAOSo4NQPy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:18:44 +0100
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
Cc: Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here are first few patches for max9867 codec driver. It is still
not enough to make it work (at least for me :)), but lets send
cleanups first.

I would be happy to read clarification about using continuous
rate - see patch 6.

Thank you,
	ladis

Ladislav Michl (6):
  ASoC: max9867: Show Kconfig entry
  ASoC: max9867: Improve error logging
  ASoC: max9867: Drop probe function
  ASoC: max9867: Fix codec capabilities
  ASoC: max9867: DSP mode
  ASoC: max9867: Use continuous sample rate

 sound/soc/codecs/Kconfig   |   3 +-
 sound/soc/codecs/max9867.c | 122 ++++++++++++---------------------------------
 sound/soc/codecs/max9867.h |   1 -
 3 files changed, 34 insertions(+), 92 deletions(-)

-- 
2.16.2
