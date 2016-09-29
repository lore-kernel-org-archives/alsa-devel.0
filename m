From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/8] ASoC: topology: Remaining kernel patches
Date: Thu, 29 Sep 2016 13:55:50 +0800
Message-ID: <cover.1475127338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9832614A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 07:49:19 +0200 (CEST)
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

Mengdong Lin (8):
  ASoC: topology: ABI - Add flags to PCM
  ASoC: topology: ABI - Add private data to PCM
  ASoC: topology: ABI - Define DAI physical PCM data formats
  ASoC: topology: ABI - Add HW configurations to BE DAI links
  ASoC: topology: ABI - Add flags and private data to BE DAI links
  ASoC: topology: ABI - Add name and stream name to BE DAI links
  ASoC: Define API to find a dai link
  ASoC: topology: Add support to configure existing BE DAI links

 include/sound/soc-dai.h   |  15 +++--
 include/sound/soc.h       |   3 +
 include/uapi/sound/asoc.h |  67 +++++++++++++++++++
 sound/soc/soc-core.c      |  42 ++++++++++++
 sound/soc/soc-topology.c  | 166 ++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 282 insertions(+), 11 deletions(-)

-- 
2.5.0
