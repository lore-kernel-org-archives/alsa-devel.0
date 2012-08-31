From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v3 0/3] introduce device_buffer
Date: Fri, 31 Aug 2012 06:44:41 +0530
Message-ID: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 9336D2663DF
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 03:08:26 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Old wine in a new bottle with added flavour now.
Based on our discussions in LPC, now we will report the combined delay value as
sum of the buffering done in driver and hardware. This is used to report delay
Additionally we tell pcm what is buffer in device/driver, this is used to check
for error calulcations

Vinod Koul (3):
  ALSA: pcm - introduce device_buffer
  ASoC: add device_buffer in asoc
  ASoC: mid-x86 - implement buffer query in sst_platform driver

 include/sound/pcm.h              |    1 +
 include/sound/soc-dai.h          |    6 ++++++
 include/sound/soc.h              |    6 ++++++
 sound/core/pcm_lib.c             |   10 +++++++++-
 sound/soc/mid-x86/sst_platform.c |   23 +++++++++++++++++++++++
 sound/soc/mid-x86/sst_platform.h |    4 +++-
 sound/soc/soc-pcm.c              |   13 ++++++++++++-
 7 files changed, 60 insertions(+), 3 deletions(-)

-- 
1.7.9.5
