From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 00/11] ASoC: topology: Remaining kernel
	patches
Date: Fri,  9 Sep 2016 19:41:24 +0800
Message-ID: <cover.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B646726648B
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:35:20 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
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


History:
v2: Add the reason for creating BE DAI & DAI links by topology to commit
    message.
    Drop support for configuring DPCM trigger ordering in topology.


Guneshwor Singh (1):
  ASoC: topology: Add FE DAIs only if not already added

Mengdong Lin (10):
  ASoC: topology: Able to create BE DAIs
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
 include/sound/soc-topology.h |   1 +
 include/sound/soc.h          |   2 +
 include/uapi/sound/asoc.h    |  90 ++++++++++-
 sound/soc/soc-core.c         |  36 ++++-
 sound/soc/soc-topology.c     | 355 ++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 446 insertions(+), 53 deletions(-)

-- 
2.5.0
