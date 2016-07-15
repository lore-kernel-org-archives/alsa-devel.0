From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/5] topology: Enhance support for private
	data
Date: Fri, 15 Jul 2016 20:17:21 +0800
Message-ID: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C3E266A7C
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 14:12:24 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, o-takashi@sakamocchi.jp, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

There is no ABI change in this series.

We finished verification on latest Intel platforms. There will be 4 or 5
series. Later series will come with some ABI update for topology. The size
check on ABI objects in current ASoC kernel will detect possible ABI
version mismatch between user space and kernel

History:
v2: fix compiler warnings. There are 2 warnings left in topology/pcm.c
    that are not caused by this series and will be fixed in later patches.

Mengdong Lin (5):
  topology: An element can refer to multipe data sections in text conf
    file
  topology: Merge lookup for data reference into tplg_copy_data()
  topology: Change uuid value to 16 separate characters in text conf
    file
  topology: Parse vendor private data for manifest
  topology: Tuple type can have an extenstion

 include/topology.h        |  69 ++++++++++-
 src/topology/ctl.c        |  52 +++-----
 src/topology/dapm.c       |  17 ++-
 src/topology/data.c       | 307 ++++++++++++++++++++++++++++++++++++++--------
 src/topology/elem.c       |   4 +
 src/topology/parser.c     |  28 ++++-
 src/topology/tplg_local.h |  15 ++-
 7 files changed, 395 insertions(+), 97 deletions(-)

-- 
2.5.0
