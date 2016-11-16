From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/7] topology: Add support for physical DAIs
Date: Wed, 16 Nov 2016 14:36:06 +0800
Message-ID: <cover.1479277829.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B2EE6266639
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 07:34:20 +0100 (CET)
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

This is the last series for topology user space atm.

This series adds support for physical DAIs and includes a few minor fixes.
All ABI updates here can be supported by kernel in a backward compatible
way.

Guneshwor Singh (3):
  topology: ABI - Define new types for physical DAI
  topology: Support configuring physical DAIs by C API
  topology: Export physical DAIs to the binary for kernel

Mengdong Lin (4):
  topology: ABI - Update manifest and pump ABI version to 5
  topology: Parse physical DAIs in text conf file
  topology: ABI - Add voice wake up flag for DAI links
  topology: Revise document and comments for ABI v5

 include/sound/asoc.h      |  37 +++++++-
 include/topology.h        |  94 ++++++++++++-------
 src/topology/builder.c    |  11 +++
 src/topology/data.c       |   4 +
 src/topology/elem.c       |   4 +
 src/topology/parser.c     |  16 ++++
 src/topology/pcm.c        | 223 +++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/tplg_local.h |   7 ++
 8 files changed, 362 insertions(+), 34 deletions(-)

-- 
2.5.0
