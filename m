From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] arizona: Improvements to codec DVFS control
Date: Mon, 9 Jun 2014 16:00:13 +0100
Message-ID: <20140609150013.GA5229@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D67B6264FF0
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 17:00:17 +0200 (CEST)
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
To: sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This set of changes cleans up the way the drivers handle
the control of internal subsystem clocks for codecs with
DVFS. This previously relied on the clock control happening
as a side-effect of changing the regulator voltage, rather
than explicitly, which assumed that you were uusing the
built-int regulator. Also DVFS control was being done from
the ADSP driver despite that driver supposedly being codec-
agnostic.
There are other cases on some codecs where DVFS control is
needed so this sequence of patches cleans up the way DVFS
is implemented and adds the extra case of DVFS boost for
higher sample rates on WM8997 and WM5102

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
 sound/soc/codecs/wm_adsp.c       |   76 +---------------------------------
 sound/soc/codecs/wm_adsp.h       |   11 +++--
 8 files changed, 170 insertions(+), 89 deletions(-)

-- 
1.7.2.5
