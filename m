From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] ASoC: SOF: fix undefined references
Date: Tue,  7 May 2019 11:32:34 -0500
Message-ID: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3137FF89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 18:32:42 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, kbuild-all@01.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

kbuild reported a couple of valid issues with undefined
references. It's a bit embarrassing that they were not found earlier
since the SOF tree is tracked for each PR...

Pierre-Louis Bossart (2):
  ASoC: SOF: xtensa: fix undefined references
  ASoC: SOF: core: fix undefined nocodec reference

 sound/soc/sof/core.c        | 10 +++++-----
 sound/soc/sof/intel/Kconfig |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1
