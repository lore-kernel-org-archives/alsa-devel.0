From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 0/3] introduce device_buffer
Date: Fri, 31 Aug 2012 00:42:35 +0530
Message-ID: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC8926627F
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 21:05:40 +0200 (CEST)
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

Old wine ina  new bottle, so here is the second attempt for adding the notion of
how devices (in my case a DSP) can buffer data and that can be used by sound
core

Vinod Koul (3):
  ALSA: pcm - introduce device_buffer
  ASoC: add device_buffer in asoc
  ASoC: mid-x86 - implement buffer query in sst_platform driver

 include/sound/pcm.h              |    1 +
 include/sound/soc-dai.h          |    6 ++++++
 include/sound/soc.h              |    7 ++++++-
 sound/core/pcm_lib.c             |   14 +++++++++++---
 sound/core/pcm_native.c          |    6 +++---
 sound/soc/mid-x86/sst_platform.c |   23 +++++++++++++++++++++++
 sound/soc/mid-x86/sst_platform.h |    4 +++-
 sound/soc/soc-pcm.c              |   13 +++++++++++++
 8 files changed, 66 insertions(+), 8 deletions(-)

-- 
1.7.9.5
