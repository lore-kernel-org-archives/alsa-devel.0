From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] Arizona FLL fixes and Clocking Improvements
Date: Fri, 2 Sep 2016 16:52:42 +0100
Message-ID: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

The first 3 patches in this series fix some small issues with
the FLL configuration in the driver. The second 3 patches add
support for requesting the input clocks for the CODEC through the
clock framework. This is some what of an intermediate step until
all the clocking itself in the CODEC can be brought under the
clock framework but as there are machine drivers that want to be
merged now with source clocks that require gating and difficult
to resolve issues between the SPI and clock framework an
intermediate solution seems warranted.

Whilst the two halfs of this series do fairly different things,
I have sent them as once series as they touch a lot of the same
code, so this seemed the simpler approach to pushing them both
through. The series is based of Mark's ASoC for-next tree.

Thanks,
Charles

Charles Keepax (5):
  ASoC: arizona: Correct handling of FLL theta in synchroniser mode
  ASoC: arizona: Allow specification of base for arizona_is_enabled_fll
  ASoC: arizona: Avoid changing SYNC_ENA whilst the FLL_ENA is set
  ASoC: arizona: Add gating for clock when used for direct MCLK
  ASoC: arizona: Add gating for source clocks of the FLLs

Sylwester Nawrocki (1):
  mfd: arizona: Add gating of external MCLKn clocks

 drivers/mfd/arizona-core.c       |  30 +++++++++-
 include/linux/mfd/arizona/core.h |   9 +++
 sound/soc/codecs/arizona.c       | 124 +++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/arizona.h       |   2 +
 sound/soc/codecs/cs47l24.c       |   6 +-
 sound/soc/codecs/wm5102.c        |   9 ++-
 sound/soc/codecs/wm5110.c        |  10 +++-
 sound/soc/codecs/wm8997.c        |   9 ++-
 sound/soc/codecs/wm8998.c        |   6 +-
 9 files changed, 179 insertions(+), 26 deletions(-)

-- 
2.1.4
