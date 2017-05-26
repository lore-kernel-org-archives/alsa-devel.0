From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Add Support for MIC
	select module
Date: Fri, 26 May 2017 08:50:00 +0530
Message-ID: <1495768803-24217-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF84266D49
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 05:18:04 +0200 (CEST)
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

This series adds support in DSP to add support for MIC select module which
allows user to select 1 to N channels from DMIC channel input.

Further it also adds support in bxt-rt298 machine for such a module.

Kranthikumar, GudishaX (3):
  ASoC: Intel: Skylake: Add mic-select module type
  ASoC: Intel: Skylake: Add enum control for mic selection
  ASoC: Intel: Boards: Add 4-channel DMIC fixup.

 sound/soc/intel/boards/bxt_rt298.c           |   7 +-
 sound/soc/intel/skylake/skl-messages.c       |   2 +
 sound/soc/intel/skylake/skl-topology.c       | 143 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |  20 ++++
 sound/soc/intel/skylake/skl-tplg-interface.h |   2 +
 5 files changed, 169 insertions(+), 5 deletions(-)

-- 
1.9.1
