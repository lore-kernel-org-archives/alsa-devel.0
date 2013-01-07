From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH 0/3] ALSA: pxa27x: ac97 reset fixes
Date: Mon,  7 Jan 2013 13:55:11 -0800
Message-ID: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id A7FE2265162
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 22:55:34 +0100 (CET)
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
Cc: Marek Vasut <marex@denx.de>, Mike Dunn <mikedunn@newsguy.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Igor Grinberg <grinberg@compulab.co.il>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
problems:
  - cold reset fails because the GCR register is not set correctly
  - warm reset fails because some code used to work around a hardware bug is
    broken
  - the intent of the work-around code is obfuscated by unfortunate function
    naming

This patch set replaces some earlier individual patches that had some problems.
Thanks Robert and Igor.

Changelog:
v2:
  - don't specify the LPM flag DRIVE_HIGH in #define for the mfp config
  - patches 2 and 3 are combined into one patch
  - mfp level and direction are set only once, during driver initialization

Mike Dunn (3):
  ALSA: pxa2xx: fix ac97 cold reset
  ALSA: pxa27x: fix ac97 warm reset
  ALSA: pxa27x: rename pxa27x_assert_ac97reset()

 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 ++
 arch/arm/mach-pxa/pxa27x.c                  |   24 ++++++++++++------
 sound/arm/pxa2xx-ac97-lib.c                 |   34 +++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 15 deletions(-)

-- 
1.7.8.6
