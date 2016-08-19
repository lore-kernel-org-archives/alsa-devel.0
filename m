From: mengdong.lin@linux.intel.com
Subject: [PATCH 00/13] ASoC: topology: Remaining kernel patches
Date: Fri, 19 Aug 2016 18:11:29 +0800
Message-ID: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0CA26659C
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:05:37 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series contains all remaining kernel patches of topology, including
some ABI update to PCM (FrontEnds) and link (BackEnds) objects. We don't
user more series.

User will be able to create BE DAIs and DAI links, configure more for FE
links. Code are verified and can cover reqeust of Intel pre-release
platforms for next year, so ABI should be stable.

Current kernel topology code does not really touch Codec-Codec links 
since there is no user requst atm. We can add support for CC links later
by reusing code and data structures for BE links, and no need to revise
ABI.

Guneshwor Singh (1):
  ASoC: topology: Add FE DAIs only if not already added

Mengdong Lin (12):
  ASoC: topology: Able to create BE DAIs
  ASoC: topology: ABI - Add sig_bits to stream caps
  ASoC: topology: ABI - Define DPCM trigger ordering for PCM
  ASoC: topology: ABI - Add flags to PCM
  ASoC: topology: ABI - Add private data to PCM
  ASoC: topology: ABI - Add name & component info to BE/CC links
  ASoC: topology: ABI - Define DAI physical PCM data formats
  ASoC: topology: ABI - Add HW configurations to BE/CC links
  ASoC: topology: ABI - Add flags and private data to BE/CC links
  ASoC: Define API to find a dai link by id
  ASoC: Probe link components after finding new links
  ASoC: topology: Able to create BE DAI links

 include/sound/soc-dai.h      |  15 +-
 include/sound/soc-dpcm.h     |  13 --
 include/sound/soc-topology.h |   1 +
 include/sound/soc.h          |   2 +
 include/uapi/sound/asoc.h    | 106 ++++++++++++-
 sound/soc/soc-core.c         |  36 ++++-
 sound/soc/soc-topology.c     | 359 ++++++++++++++++++++++++++++++++++++++-----
 7 files changed, 466 insertions(+), 66 deletions(-)

-- 
2.5.0
