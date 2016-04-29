From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/6] topology: complete PCM parsing and code
	refactoring
Date: Fri, 29 Apr 2016 11:02:50 +0800
Message-ID: <cover.1461898635.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1B1265141
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 04:59:54 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is no ABI change in this series.

This series fixes bugs and missing info of PCM (Front-end DAI & DAI link)
defined by the text conf file.

There is also some code refactoring, as a preparation for Back-end DAI
support and ABI update which is under internal test and review atm.

History:
v2: Fix memory leak on realloc failure. The original obj pointer is reserved
    and so it can be freed at last by tplg_elem_free().

Mengdong Lin (6):
  topology: Set manifest size for ABI
  topology: Refactor functions to parse and build streams
  topology: Use generic pointer to realloc buffer for private data
  topology: Fix pcm ID & name parsing
  topology: Parse front-end DAI name and ID for the PCM
  topology: Update PCM configurations in Broadwell text conf file

 include/sound/asoc.h                       |   2 +-
 include/topology.h                         |   4 +
 src/conf/topology/broadwell/broadwell.conf |  34 ++++++---
 src/topology/data.c                        |  26 +++----
 src/topology/parser.c                      |   4 +-
 src/topology/pcm.c                         | 119 ++++++++++++++++++++++-------
 src/topology/tplg_local.h                  |   2 +-
 7 files changed, 133 insertions(+), 58 deletions(-)

-- 
2.5.0
