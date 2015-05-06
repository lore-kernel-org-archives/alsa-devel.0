From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: let machines configure SSP
	configuration
Date: Wed,  6 May 2015 22:06:39 +0530
Message-ID: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 29501260632
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:16 +0200 (CEST)
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
Cc: patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This series first add frame and data polarity to ssp config and then starts
to use local values for ssp config and then eventually lets that be loaded
by hw_params and updates by pcm format and tdm calls to allow machine t
specify these parameters

Vinod Koul (5):
  ASoC: Intel: add frame and data polarity to ssp config
  ASoC: Intel: use local values for ssp configuration
  ASoC: Intel: load hw_defaults in hw_params of ssp be
  ASoC: intel: add support for specifying PCM format
  ASoC: Intel: add support for configuring TDM slots for SSP

 sound/soc/intel/atom/sst-atom-controls.c     | 167 +++++++++++++++++++++++----
 sound/soc/intel/atom/sst-atom-controls.h     |   7 ++
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  47 +++++++-
 sound/soc/intel/atom/sst-mfld-platform.h     |   2 +
 4 files changed, 197 insertions(+), 26 deletions(-)

-- 
1.9.1
