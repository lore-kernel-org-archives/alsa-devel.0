From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/3] ASoC: Intel: rework the mfld platform
	driver
Date: Thu, 15 May 2014 21:38:14 +0530
Message-ID: <1400170097-7653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9292B261B0C
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 18:23:27 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is the remaining bits of the v2 which were removed last time around. One
patch was wrongly applied so reverting that and adding two other missed in the
series.

Also added Liam's ack

Vinod Koul (3):
  Revert "ASoC: Intel: rename pcm dias to media dai"
  ASoC: Intel: add drain_notify support
  ASoC: Intel: remove codec memeber from codec structs

 sound/soc/intel/sst-mfld-dsp.h               |    4 --
 sound/soc/intel/sst-mfld-platform-compress.c |   13 +++++++-
 sound/soc/intel/sst-mfld-platform-pcm.c      |   39 ++++++++++++-------------
 sound/soc/intel/sst-mfld-platform.h          |    2 +
 4 files changed, 32 insertions(+), 26 deletions(-)
