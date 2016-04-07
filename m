From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/7] topology: Add support for vendor tuples
Date: Thu,  7 Apr 2016 15:27:20 +0800
Message-ID: <cover.1460013338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC4F265158
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 09:25:24 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series addes support for vendor tuples to topology, to avoid
importing binary data blob from other files.

Backward compatibility of ABI is not impacted. A kernel patch is also
submitted "ASoC: topology: ABI - Define types for vendor tuples".

The 1st patch is small code cleanup.
The 2nd patch is a preparation, since tuples will need the type-specific
free handler.

History:
v2: add check on string length, use strtol() to get hex value,
    and fix memory leak.
v3: Fix overflow on uuid string copy. Use strtoul() to get unsigned
    vendor values and check range, tested on 32 & 64 bit systems.

Mengdong Lin (7):
  topology: Use the generic pointer to free an element's object
  topology: Define a free handler for the element
  topology: Add doc for vendor tuples
  topology: ABI - Define types for vendor tuples
  topology: Add support for vendor tokens
  topology: Add support for parsing vendor tuples
  topology: Build data objects with tuples

 include/sound/asoc.h      |  42 +++-
 include/topology.h        |  79 +++++++-
 src/topology/data.c       | 503 +++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/elem.c       |  15 +-
 src/topology/parser.c     |  24 +++
 src/topology/tplg_local.h |  47 +++++
 6 files changed, 702 insertions(+), 8 deletions(-)

-- 
2.5.0
