From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/5] ASoC: topology: Add support for FE DAI &
	DAI links
Date: Thu, 31 Dec 2015 16:35:17 +0800
Message-ID: <cover.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B654265AE8
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 09:18:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series allows topology to create FE DAI and DAI links from the PCM
topology objects defined by the user space.

Mengdong Lin (5):
  ASoC: Define soc_add_dai() to add a DAI to a component
  ASoC: Support registering a DAI dynamically
  ALSA: pcm: Add snd_pcm_rate_range_to_bits()
  ASoC: topology: Add FE DAIs dynamically
  ASoC: topology: Add FE DAI links dynamically

 include/sound/pcm.h          |   2 +
 include/sound/soc-dai.h      |   1 +
 include/sound/soc-topology.h |  21 +++--
 include/sound/soc.h          |   5 +-
 sound/core/pcm_misc.c        |  27 ++++++
 sound/soc/soc-core.c         | 128 ++++++++++++++++++++--------
 sound/soc/soc-topology.c     | 195 ++++++++++++++++++++++++++++++++++---------
 7 files changed, 291 insertions(+), 88 deletions(-)

-- 
2.5.0
