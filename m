From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4 v2] arizona: Improvements to codec DVFS
	control
Date: Fri, 20 Jun 2014 15:41:09 +0100
Message-ID: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EBE32650DA
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 16:50:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

Respin of Richard's DVFS series, from me since he is on
holiday. I have based these on Mark's ASoC for-next branch
as there a few changes in there to the same parts of code.
But let me know if you would rather have a series based on
Lee's tree instead.

This set of changes cleans up the way the drivers handle
the control of internal subsystem clocks for codecs with
DVFS. This previously relied on the clock control happening
as a side-effect of changing the regulator voltage, rather
than explicitly, which assumed that you were using the
built-in regulator. Also DVFS control was being done from
the ADSP driver despite that driver supposedly being codec-
agnostic.
There are other cases on some codecs where DVFS control is
needed so this sequence of patches cleans up the way DVFS
is implemented and adds the extra case of DVFS boost for
higher sample rates on WM8997 and WM5102


Changes since v1:
 - Changed mask variable to flags to be more consistent
   with its usage
 - Fixed minor tabbing issue
 - Adding missing SND_SOC_DAPM_PRE_PMD event flag in WM_ADSP2_E


Richard Fitzgerald (4):
  mfd: arizona: Export function to control subsystem DVFS
  ASoC: wm_adsp: Move DVFS control into codec driver
  ASoC: arizona: Add DVFS handling for sample rate control
  regulator: arizona-ldo1: Do not control clocking from regulator

 drivers/mfd/arizona-core.c       |   84 ++++++++++++++++++++++++++++++++++++++
 drivers/regulator/arizona-ldo1.c |    5 --
 include/linux/mfd/arizona/core.h |   12 +++++
 sound/soc/codecs/arizona.c       |   22 +++++++++-
 sound/soc/codecs/wm5102.c        |   47 ++++++++++++++++++++-
 sound/soc/codecs/wm5110.c        |    2 +-
 sound/soc/codecs/wm_adsp.c       |   73 +--------------------------------
 sound/soc/codecs/wm_adsp.h       |   13 +++---
 8 files changed, 171 insertions(+), 87 deletions(-)

-- 
1.7.2.5
