From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] ASoC: Intel: boards: Enabled HDMI/DP and
	update WOV on SKL machines
Date: Wed, 24 Feb 2016 11:27:37 +0530
Message-ID: <1456293464-19646-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DDBA0261484
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 06:54:04 +0100 (CET)
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

This series adds the multiple port support for HDMI and DP on respective SKL
machine drivers. Also the WoV sink is removed as that needs to be associated
with PCM device and not a DAPM Sink

Jeeja KP (5):
  ASoC: Intel: boards: Enable HDMI and DP on skl_rt286 machine
  ASoC: Intel: boards: Enable HDMI and DP on nau88l2 machine
  ASoC: Intel: boards: Remove WoV sink in skl_rt286
  ASoC: Intel: boards: Remove WoV sink in nau88125_ssm4567 machine
  ASoC: Intel: boards: Remove WoV sink in nau88125_max98357a machine

Sathya Prakash M R (1):
  ASoC: Intel: boards: Add IV feedback route for nau88l25_ssm4567
    machine

Sathyanarayana Nujella (1):
  ASoC: Intel: boards: Enable HDMI and DP on SKL nau88l25_max98357
    machine

 sound/soc/intel/Kconfig                         |   3 +
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 122 +++++++++++++++++---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 145 +++++++++++++++++++++---
 sound/soc/intel/boards/skl_rt286.c              | 113 ++++++++++++++++--
 4 files changed, 339 insertions(+), 44 deletions(-)

-- 
1.9.1
