From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 0/6] More code cleanup for ASoC ux500
Date: Fri, 24 May 2013 12:39:14 +0200
Message-ID: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id BB21B2650B9
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 12:39:24 +0200 (CEST)
Received: by mail-ee0-f42.google.com with SMTP id c50so2486178eek.15
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 03:39:24 -0700 (PDT)
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

this series contains more various code cleanup patches that I put
together while working on other stuff this drivers.

The first patch is actually a resend, as Linus Walleij agreed to drop
that code in the original thread (https://lkml.org/lkml/2013/5/17/487).

The others are just a bunch of sparse fixes and generic code cleanup and
dead code removal.

Thanks,
Fabio


Fabio Baltieri (6):
  ASoC: ux500: Drop pinctrl sleep support
  ASoC: ab8500-codec: Move codec ops on a separate structure
  ASoC: ux500: Drop dangling struct i2s_controller
  ASoC: ux500: Drop unused code from msp headers
  ASoC: ux500: Add missing mop500_ab8500.h include
  ASoC: ux500: Drop redundant msp id enumerations

 sound/soc/codecs/ab8500-codec.c | 19 ++++-------
 sound/soc/ux500/mop500_ab8500.c |  1 +
 sound/soc/ux500/ux500_msp_dai.h |  2 --
 sound/soc/ux500/ux500_msp_i2s.c | 75 ++---------------------------------------
 sound/soc/ux500/ux500_msp_i2s.h | 59 ++------------------------------
 5 files changed, 12 insertions(+), 144 deletions(-)

-- 
1.8.2
