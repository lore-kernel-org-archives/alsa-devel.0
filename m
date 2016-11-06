From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/2] ASoC: Intel: Skylake: remaining D0i3
	patches
Date: Sun,  6 Nov 2016 19:01:47 +0530
Message-ID: <1478439109-22541-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B788D266218
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 14:22:40 +0100 (CET)
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

Hi Mark,

Looks like last two patches in last series posted were missed, so I am
resending this

Jayachandran B (2):
  ASoC: Intel: Skylake: Flush pending D0i3 request on suspend
  ASoC: Intel: Skylake: remove pci device enabling calls on suspend

 sound/soc/intel/skylake/skl-messages.c | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c          | 12 ++++++++++--
 sound/soc/intel/skylake/skl.h          |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
1.9.1
