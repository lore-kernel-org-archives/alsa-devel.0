From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/2] ASoC: core/Intel: fix module-in-use
	error
Date: Fri,  1 Feb 2019 11:22:22 -0600
Message-ID: <20190201172224.14549-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CDC267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 18:22:41 +0100 (CET)
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

Recent simplifications to the SOF driver, which now follows the same
device hierarchy as the Skylake driver, expose a conceptual issue with
the module refcount that blocks module rmmod/modprobe loop tests for
both drivers.

Sending as an RFC since I don't fully understand the initial design
and might have missed a simpler solution.

Pierre-Louis Bossart (2):
  ASoC: core: don't increase component module refcount unconditionally
  ASoC: Intel: Skylake: set .ignore_module_refcount field in component

 include/sound/soc.h               | 3 +++
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 sound/soc/soc-core.c              | 6 ++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1
