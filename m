From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/4] topology: fix some gcc warnings
Date: Wed, 18 Nov 2015 02:21:23 -0500
Message-ID: <cover.1447825540.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 55757265375
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 08:06:03 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series can fix the following gcc warnings:
-Wunused-function -Wsign-compare -Wunused-variable -Wtype-limits

Mengdong Lin (4):
  topology: Remove unused function write_data_block()
  topology: Change variable type to fix gcc warning
  topology: Remove unused variables
  topology: Fix comparison of unsigned expression < 0

 src/topology/builder.c | 24 ------------------------
 src/topology/channel.c |  6 ++++--
 src/topology/ctl.c     |  6 ++++--
 src/topology/pcm.c     |  9 +++------
 4 files changed, 11 insertions(+), 34 deletions(-)

-- 
2.5.0
