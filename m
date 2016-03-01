From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Update the IVI
	feedback path
Date: Tue,  1 Mar 2016 07:59:09 +0530
Message-ID: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 77B052607F7
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 03:26:47 +0100 (CET)
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


This patch series fixes the blob query direction and then uses that in IVI
feedback path in nau88125_ssm4567 machine.

Jeeja KP (3):
  ASoC: Intel: Skylake: correct direction in blob query
  ASoC: Intel: Skylake: Add IVI feedback path in nau88125_ssm4567 machine
  ASoC: Intel: Skylake: remove IVI codec loop in skl_nau88l25_ssm4567
    machine

 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 21 +++------------------
 sound/soc/intel/skylake/skl-topology.c        | 15 ++++++++-------
 2 files changed, 11 insertions(+), 25 deletions(-)

-- 
1.9.1
