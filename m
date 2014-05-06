From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/5] ASoC: Trivial bits and cleanups
Date: Tue,  6 May 2014 09:39:36 +0200
Message-ID: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 94CFC260816
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series contains a few cleanup patches that came up while working on the
componentization, but all also make sense on their own.

The biggest change is admittedly the removal of the suspend/resume code from the
atmel-pcm-pdc driver and may not seem trivial at first. But this code has been
fully broken for over 4 years, was always partially broken and was never really
needed in the first place. And right now it is blocking other cleanups.

Everything else is just removal of unused fields and the consolidation of
duplicated fields.

Depends on: asoc/topic/component

- Lars

Lars-Peter Clausen (5):
  ASoC: Remove card's DAI list
  ASoC: Remove unused 'list' field form card
  ASoC: Remove unused num_dai field from CODEC
  ASoC: atmel-pcm-pdc: Remove broken suspend/resume code
  ASoC: Remove runtime field from DAI

 include/sound/soc-dai.h         |  2 --
 include/sound/soc.h             |  4 ---
 sound/soc/atmel/atmel-pcm-pdc.c | 63 -----------------------------------------
 sound/soc/soc-compress.c        |  1 -
 sound/soc/soc-core.c            |  7 -----
 sound/soc/soc-pcm.c             |  1 -
 6 files changed, 78 deletions(-)

-- 
1.8.0
