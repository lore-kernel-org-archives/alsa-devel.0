From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 0/2] genalloc: rename dev_get_gen_pool() and
	of_get_named_gen_pool()
Date: Thu, 11 Jun 2015 16:26:32 +0300
Message-ID: <1434029192-7082-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 1168C266507
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 15:28:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Vinod Koul <vinod.koul@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sascha Hauer <kernel@pengutronix.de>, dmaengine@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Trivial nonfunctional change initially based on discussion
https://lkml.org/lkml/2015/6/8/588

Worth to mention that instead of the assumed new name
dev_gen_pool_get(), this change attempts to be more close to other
in-kernel interfaces and new function name is just gen_pool_get().

The change is based and tested on linux-next.

Vladimir Zapolskiy (2):
  genalloc: rename dev_get_gen_pool() to gen_pool_get()
  genalloc: rename of_get_named_gen_pool() to of_gen_pool_get()

 arch/arm/mach-at91/pm.c                   |  2 +-
 arch/arm/mach-imx/pm-imx5.c               |  2 +-
 arch/arm/mach-imx/pm-imx6.c               |  2 +-
 drivers/dma/mmp_tdma.c                    |  2 +-
 drivers/media/platform/coda/coda-common.c |  4 ++--
 include/linux/genalloc.h                  |  6 +++---
 lib/genalloc.c                            | 14 +++++++-------
 sound/core/memalloc.c                     |  2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.1.4
