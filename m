From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: DAPM/topology oops/use-after-free
	fixes
Date: Fri,  1 Feb 2019 11:05:10 -0600
Message-ID: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CAA1267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 18:05:20 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

KASAN checks and more SOF stress-tests expose bugs that have apparently
been there for a very long time.

Guennadi Liakhovetski (1):
  ASoC: topology: fix oops/use-after-free case with dai driver

Pierre-Louis Bossart (2):
  ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables
  ASoC: dapm: fix use-after-free issue with dailink sname

 sound/soc/soc-core.c     |  2 +-
 sound/soc/soc-dapm.c     | 45 +++++++++++++++++++++++++++++++++++++++-
 sound/soc/soc-topology.c |  5 +++++
 3 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.17.1
