From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/2] ASoC: Remove mfld dead code
Date: Wed, 10 Jan 2018 15:59:33 +0530
Message-ID: <1515580175-27016-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E55C3266C5E
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 11:25:26 +0100 (CET)
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
Cc: patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Medfield machine was not compiling for long on mainline. Since no one
complained, lets remove the dead code and associated codec.

Vinod Koul (2):
  ASoC: Intel: remove mfld_machine
  ASoC: sn95031: remove this code

 sound/soc/codecs/Kconfig              |   4 -
 sound/soc/codecs/Makefile             |   1 -
 sound/soc/codecs/sn95031.c            | 936 ----------------------------------
 sound/soc/codecs/sn95031.h            | 133 -----
 sound/soc/intel/boards/Kconfig        |  14 -
 sound/soc/intel/boards/mfld_machine.c | 430 ----------------
 6 files changed, 1518 deletions(-)
 delete mode 100644 sound/soc/codecs/sn95031.c
 delete mode 100644 sound/soc/codecs/sn95031.h
 delete mode 100644 sound/soc/intel/boards/mfld_machine.c

-- 
2.7.4
