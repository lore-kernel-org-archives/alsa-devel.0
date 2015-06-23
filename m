From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: skylake - match braces for
	if-else
Date: Tue, 23 Jun 2015 22:40:11 +0530
Message-ID: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F7326049D
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 19:08:35 +0200 (CEST)
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

Coding style mandates that if-else should match braces even if one of them
is a single line statement. Fix it in two places missed earlier

Mark, you can also fold these two patches with SKL driver series (1st and
2nd patch can fold in 1st and 2nd patch respectively) or apply independetly,
either way okay


Vinod Koul (2):
  ASoC: Intel: skl-pcm.c match braces for if-else
  ASoC: Intel: skl.c match braces for if-else

 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 sound/soc/intel/skylake/skl.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
1.9.1
