From: mengdong.lin@linux.intel.com
Subject: [PATCH 00/22] topology: Remaining user space patches
	of ABI v5
Date: Thu, 27 Oct 2016 15:09:44 +0800
Message-ID: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 922E926688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:08:30 +0200 (CEST)
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

This series has all remaining topology user space patches for ABI update
of version 5.

Backward compatibility from ABI v4 is assured by the kernel series
"ASoC: topology: Remaining kernel patches of ABI v5", submitted as well.

Guneshwor Singh (3):
  topology: ABI - Define new types for physical DAI
  topology: Support configuring physical DAIs by C API
  topology: Export physical DAIs to the binary for kernel

Mengdong Lin (19):
  topology: ABI - Update stream caps and PCM objects to ABI v5
  topology: Parse sig_bits of stream caps
  topology: Parse flags for PCM
  topology: Define a function to build a single PCM element
  topology: Parse and build private data for PCM
  topology: tplg_elem_lookup() checks parameter before searching
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
  topology: ABI - Update manifest to ABI v5
  topology: Parse physical DAIs in text conf file

 include/sound/asoc.h      | 108 ++++++-
 include/topology.h        | 149 ++++++++-
 src/topology/builder.c    |  11 +
 src/topology/data.c       |   4 +
 src/topology/elem.c       |  12 +
 src/topology/parser.c     |  38 ++-
 src/topology/pcm.c        | 775 +++++++++++++++++++++++++++++++++++++++++++---
 src/topology/tplg_local.h |  21 +-
 8 files changed, 1064 insertions(+), 54 deletions(-)

-- 
2.5.0
