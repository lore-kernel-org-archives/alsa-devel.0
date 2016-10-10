From: mengdong.lin@linux.intel.com
Subject: [PATCH v4 00/11] ASoC: topology: Remaining kernel
	patches
Date: Mon, 10 Oct 2016 22:23:08 +0800
Message-ID: <cover.1476108863.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BE215260083
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 16:22:20 +0200 (CEST)
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

This version can support old topology ABI v4 in a backward compatible way,
assuming users start to use topology from ABI v4.

This series contains all remaining kernel patches of topology, including
some ABI update to PCM (FrontEnds) and link (BackEnds) objects.

User will be able to config existing BE DAI links, configure more for FE
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

v3: Topology no longer creates BE DAI or BE DAI links, but only configure
    existing ones. The API to find a DAI link can also check the name and
    stream name in case a soc card doesn't use unique ID for DAI links.
    The user space code is also ready.

v4: Support ABI udpate and be backward compatible for topology ABI v4.
    Code refactoring to configure physical DAIs.

Mengdong Lin (11):
  ASoC: topology: Make manifest backward compatible from ABI v4
  ASoC: topology: Make PCM backward compatible from ABI v4
  ASoC: topology: Not quit on topology file of ABI version 4
  ASoC: topology: ABI - Add flags and private data to PCM
  ASoC: topology: ABI - Define DAI physical PCM data formats
  ASoC: topology: ABI - Update physical DAI link configuration for
    version 5
  ASoC: Define API to find a dai link
  ASoC: topology: Add support to configure existing physical DAI links
  ASoC: topology: Rename the function to create a FE link
  ASoC: topology: ABI - Rename struct and type for physical DAIs
  ASoC: topology: Rename functions & variables for physical links

 include/sound/soc-dai.h   |  15 +-
 include/sound/soc.h       |   3 +
 include/uapi/sound/asoc.h |  91 +++++++-
 sound/soc/soc-core.c      |  42 ++++
 sound/soc/soc-topology.c  | 544 +++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 623 insertions(+), 72 deletions(-)

-- 
2.5.0
