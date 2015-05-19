From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/8] ASoC: Intel: refactor common SST IPC
	handling
Date: Tue, 19 May 2015 15:00:32 +0530
Message-ID: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B475264F10
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:29:44 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This series refactors the common SST IPC code to remove some hardcoded
assumption which are no longer valid for future platforms like Skylake,
These are made configurable and right configuration applied for respective
drivers. The changes are mailbox sizes and dsp busy checks.

changes in v2:
 - fix the mem allocation for IPC mailbox

Subhransu S. Prusty (8):
  ASoC: Intel: Create an ops to check for DSP busy
  ASoC: Intel: Move the busy check to ops for Baytrail
  ASoC: Intel: Move the busy check to ops for HSW
  ASoC: Intel: Remove the direct register reference from common ipc
  ASoC: Intel: Allow to configure max size for mailbox data
  ASoC: Intel: Initialize max mailbox size for baytrail
  ASoC: Intel: Initialize max mailbox size for haswell
  ASoC: Intel: Allocate for the mailbox with max size

 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 11 ++++++++++
 sound/soc/intel/common/sst-ipc.c            | 34 +++++++++++++++++++++++++----
 sound/soc/intel/common/sst-ipc.h            |  7 ++++--
 sound/soc/intel/haswell/sst-haswell-ipc.c   | 12 ++++++++++
 4 files changed, 58 insertions(+), 6 deletions(-)

-- 
1.9.1
