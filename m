From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: More Kabylake machine support
Date: Wed, 13 Jul 2016 22:13:42 +0530
Message-ID: <1468428227-8239-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E092260851
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 18:36:39 +0200 (CEST)
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

We have two more kbl machines, one with nau88l25_ssm4567 and second one with
nau88l25_max98357a. This is similar to skylake which had the same
combinations.

To add kbl IDs to existing machines we need to add names in id table. But
current names are more than 20 characters which is limit for platform device
id name names. So first truncate skl machines to less than 20 chars and then
add new kbl names.

Vinod Koul (5):
  ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_ssm4567
  ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_max98357a
  ASoC: Intel: Kbl: add kabylake additional machine entries
  ASoC: Intel: board: add kabylake nau88l25_max98357a machine id
  ASoC: Intel: board: add kabylake nau88l25_ssm4567 machine id

 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 12 ++++++++++--
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 12 ++++++++++--
 sound/soc/intel/skylake/skl.c                   |  6 ++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

Thanks
-- 
~Vinod
