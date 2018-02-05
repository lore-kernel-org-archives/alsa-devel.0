From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: kabylake: Adds
	da7219+max98537 machine driver
Date: Mon,  5 Feb 2018 09:59:55 +0530
Message-ID: <1517804997-13776-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B47232671BE
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 05:30:18 +0100 (CET)
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
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Add kabylake machine driver & corresponding driver entry in machine table
for maxim speaker codec - max98357a, configured to ssp0 and
dialog headset codec - da7219, configured to ssp1. 

Naveen Manohar (2):
  ASoC: Intel: Add Kabylake-y Dialog Maxim machine driver
  ASoC: Intel: Add Kabylake Dialog+Maxim machine driver entry

 sound/soc/intel/boards/Kconfig                |  14 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 613 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                 |  13 +
 4 files changed, 642 insertions(+)
 create mode 100644 sound/soc/intel/boards/kbl_da7219_max98357a.c

-- 
1.9.1
