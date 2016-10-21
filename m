From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH RESEND 0/2] Arizona Clocking Improvements
Date: Fri, 21 Oct 2016 14:15:56 +0100
Message-ID: <1477055758-11490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 038022671EC
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 15:15:46 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

Add support for requesting the input clocks for the CODEC through
the clock framework. This is some what of an intermediate step
until all the clocking itself in the CODEC can be brought under
the clock framework but as there are machine drivers that want
to be merged now with source clocks that require gating and
difficult to resolve issues between the SPI and clock framework
an intermediate solution seems warranted.

The first patch in the original sending of this series is now in
mainline through the MFD tree so these just need to go through
ASoC now.

Thanks,
Charles

Charles Keepax (2):
  ASoC: arizona: Add gating for clock when used for direct MCLK
  ASoC: arizona: Add gating for source clocks of the FLLs

 sound/soc/codecs/arizona.c | 100 ++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/arizona.h |   2 +
 sound/soc/codecs/cs47l24.c |   6 ++-
 sound/soc/codecs/wm5102.c  |   9 +++-
 sound/soc/codecs/wm5110.c  |  10 +++--
 sound/soc/codecs/wm8997.c  |   9 +++-
 sound/soc/codecs/wm8998.c  |   6 ++-
 7 files changed, 125 insertions(+), 17 deletions(-)

-- 
2.1.4
