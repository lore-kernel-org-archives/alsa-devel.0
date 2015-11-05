From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Add nau88l25+ssm4567
	machine driver
Date: Thu,  5 Nov 2015 22:53:05 +0530
Message-ID: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C70260526
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 18:19:47 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This series adds one more machine driver used in SKL systems where nau88l25
and ssm4567 and connected to SoC on different SSPs, so add SSP1 BE ops
followed by machine driver and machine table entry

Fang, Yang A (1):
  ASoC: Intel: Skylake: add adi + nau8825 machine driver entry

Harsha Priya (1):
  ASoC: Intel: Skylake: Adding nau88l25+ssm4567 machine driver

Jeeja KP (1):
  ASoC: Intel: Skylake: Add support for SSP1 BE cpu dai

 sound/soc/intel/Kconfig                       |  14 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 368 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c             |  18 ++
 sound/soc/intel/skylake/skl.c                 |   2 +
 5 files changed, 404 insertions(+)
 create mode 100644 sound/soc/intel/boards/skl_nau88l25_ssm4567.c

-- 
1.9.1
