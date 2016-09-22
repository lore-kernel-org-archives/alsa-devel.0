From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/4] ASoC: Intel: Skylake: Add support for
	generating unique module ids
Date: Thu, 22 Sep 2016 14:00:36 +0530
Message-ID: <1474533040-14222-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AA9DE26704B
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 10:22:16 +0200 (CEST)
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

Driver needs to send unique module instance id to firmware while creating
the module and uses this id to communicate with DSP for setting parameters
while audio use case is ongoing.

But, we have upper bound of instance ID. The current IDs are coming from
topology but it doesn't know the upper bound and can't assign unique id's
subject to upper bounds as we can create a big graph but not all parts
running at same time.


So this series first adds APIs to allocate/free a 128bit unique id which is
built on top of ffz(). It also adds a table for finding modules of
neighbouring modules. Then driver patches are updated to use this.

Dharageswari R (4):
  ASoC: Intel: Skylake: Add module instance id generation APIs
  ASoC: Intel: Skylake: Use private instance id of modules in IPC
  ASoC: Intel: Skylake: Add table for module id for quick ref
  ASoC: Intel: Skylake: Update to use instance ids generated

 sound/soc/intel/skylake/skl-messages.c       |  24 +++--
 sound/soc/intel/skylake/skl-sst-dsp.h        |   6 ++
 sound/soc/intel/skylake/skl-sst-utils.c      | 150 ++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.c       |  32 +++++-
 sound/soc/intel/skylake/skl-topology.h       |  11 ++
 sound/soc/intel/skylake/skl-tplg-interface.h |   3 +-
 6 files changed, 211 insertions(+), 15 deletions(-)

-- 
1.9.1
