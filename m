From: mengdong.lin@linux.intel.com
Subject: [PATCH 00/13] topology: Update physical link support
	for ABI v5
Date: Sun,  6 Nov 2016 13:10:06 +0800
Message-ID: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 26095265B04
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:08:37 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series completes support for physical DAI links of ABI v5, including
ABI updates and code refactoring. The kernel can support the ABI updates
in a backward compatible way.

There will be another small series for the remaining user space patches.

Mengdong Lin (13):
  topology: Use snd_config_get_bool to simplify boolean flag parsing
  topology: Merge an element's be & cc pointer to one link pointer
  topology: Define a function to build a single physical DAI link
  topology: ABI - Define DAI physical PCM data formats
  topology: ABI - Update physical DAI link configurations to ABI v5
  topology: Rename varaibles for add physical links by C API
  topology: Define new type and section name to configure physical links
  topology: Parse HW configurations of physical DAI links defined by C
    API
  topology: Parse HW configurations of physical DAI links in text conf
    file
  topology: Parse link flags of physical DAI links
  topology: Parse and build private data of physical links
  topology: Parse name and stream name of physical DAI links
  topology: Remove BE or CC in comments of physical links C API template

 include/sound/asoc.h      |  61 ++++++-
 include/topology.h        |  91 ++++++++++-
 src/topology/elem.c       |   5 +
 src/topology/parser.c     |  20 ++-
 src/topology/pcm.c        | 407 +++++++++++++++++++++++++++++++++++++++++-----
 src/topology/tplg_local.h |  12 +-
 6 files changed, 545 insertions(+), 51 deletions(-)

-- 
2.7.4
