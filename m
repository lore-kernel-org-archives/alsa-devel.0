From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/5] ASoC: Convert pxa machine drivers to use
 use snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:51:18 +0800
Message-ID: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F254C10388C
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:51:36 +0100 (CET)
Received: by qcol42 with SMTP id l42so984216qco.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:51:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ian Molton <spyro@f2s.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This serial converts some pxa machine drivers to use use snd_soc_register_card().

Note: I don't have these hardware, so I appreciate if someone can test these patches.

Axel Lin (5):
  ASoC: pxa: Convert e740_wm9705 to use snd_soc_register_card()
  ASoC: pxa: Convert e750_wm9705 to use snd_soc_register_card()
  ASoC: pxa: Convert e800_wm9712 to use snd_soc_register_card()
  ASoC: pxa: Convert imote2 to use snd_soc_register_card()
  ASoC: pxa: Convert tosa to use snd_soc_register_card()

 arch/arm/mach-pxa/eseries.c   |   18 +++++++++
 arch/arm/mach-pxa/stargate2.c |    6 +++
 arch/arm/mach-pxa/tosa.c      |    6 +++
 sound/soc/pxa/e740_wm9705.c   |   75 +++++++++++++++++-----------------------
 sound/soc/pxa/e750_wm9705.c   |   66 ++++++++++++++++------------------
 sound/soc/pxa/e800_wm9712.c   |   66 ++++++++++++++++------------------
 sound/soc/pxa/imote2.c        |   41 +++++++++++++---------
 sound/soc/pxa/tosa.c          |   77 ++++++++++++++++-------------------------
 8 files changed, 178 insertions(+), 177 deletions(-)

-- 
1.7.5.4
