From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: simple-card/davinci-mcasp: System
	clock configuration support
Date: Mon, 15 Feb 2016 16:11:31 +0200
Message-ID: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 636C5261692
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:11:42 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Currently davinci-mcasp is hardwired for two configuration regarding to reference
clock:
McASP is master: AHCLKX is selected as source of the reference clock used to
		 generate the FS and BCLK
McASP is slave: AHCLKX is selected as output and the default AUXCLK is routed
		there.

This works in most of the boards, but not all configuration can be supported
with this limitation.
McASP uses it's internal AUXCLK as a reference clock. AUXCLK can be sourced from
the external AHCLKX pin or from internal functional clock. If the board uses
McASP as master and AHCLKX is not receiving clock, we need to be able to select
the internal clock source to be able to generate the FS and BCLK.

Since we try to move all of our boards to simple-card instead of the davinci-evm
custom machine driver, I have included Jyri's two patch to add the needed support
for it to be able to select clocks and directions.

I remember the discussion regarding to clock IDs, and to try to move to common
clock framework. I have taken a look at that path and I'm not convinced that by
trying to add ASoC level common clock handling will simplify or makes things
cleaner/simpler.

Regards,
Peter
---
Jyri Sarha (2):
  ASoC: simple-card: Add system-clock-direction DT parameter to dai
    nodes
  ASoC: simple-card: Support for selecting system clocks by ID

Peter Ujfalusi (2):
  ASoC: davinci-mcasp: Use defines for clkdiv IDs via DT binding header
  ASoC: davinci-mcasp: Improve the sysclk selection

 .../devicetree/bindings/sound/simple-card.txt      |  3 ++
 include/dt-bindings/sound/ti-mcasp.h               | 13 +++++++
 include/sound/simple_card.h                        |  2 ++
 sound/soc/davinci/davinci-mcasp.c                  | 42 ++++++++++++++++------
 sound/soc/generic/simple-card.c                    | 17 ++++++++-
 5 files changed, 66 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/sound/ti-mcasp.h

-- 
2.7.1
