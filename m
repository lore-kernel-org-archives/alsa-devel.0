From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/9] Update FLL calculations on Arizona devices
Date: Fri,  7 Mar 2014 16:34:16 +0000
Message-ID: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B3BF2659FD
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Newer versions of the Arizona IP have several differences
in the FLL configuration. The reference and synchroniser
paths have slightly difference FRATIO encodings and the
expanded encoding on the reference path should be used to
avoid integer mode operation.

This series of patches does some refactoring on the FLL
configuration code, previously calculation of the FLL
configuration was done before we knew whether this would be
applied to reference or synchroniser path. These patches
add some checks to make sure the requested clock can be
accomodated and then does the calculations once we knew
where they will be applied. Additionally, we add support for
the encodings on the newer IP.

Thanks,
Charles

Charles Keepax (9):
  ASoC: arizona: An OUTDIV of 1 is not valid, avoid this
  ASoC: arizona: Add defines for FLL configuration constants
  ASoC: arizona: Move set of OUTDIV in to arizona_apply_fll
  ASoC: arizona: Move calculation of FLL configuration
  ASoC: arizona: Don't pass Fout into arizona_calc_fll
  ASoC: arizona: Calculate OUTDIV first
  ASoC: arizona: Calculate FLL gain last
  mfd: arizona: Add support for new fratio encoding
  ASoC: arizona: Support new fratio encoding on the wm5110 rev D

 include/linux/mfd/arizona/registers.h |    6 +-
 sound/soc/codecs/arizona.c            |  254 ++++++++++++++++++++++-----------
 2 files changed, 171 insertions(+), 89 deletions(-)

-- 
1.7.2.5
