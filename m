From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/2] topology: fix some gcc warnings
Date: Thu, 19 Nov 2015 03:32:57 -0500
Message-ID: <cover.1447921888.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CFB02614A7
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 09:17:25 +0100 (CET)
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

History:
v2: Not use ABI __le32 variables but host integers (like template variables)
    in the for loop;
    Add check on endianess and quit on big-endian machines.

Mengdong Lin (2):
  topology: Not compare a for loop iterator with ABI __le32 variables
  topology: Quit and show error message on big-endian machines

 src/topology/ctl.c        | 22 +++++++++++-----------
 src/topology/parser.c     | 15 +++++++++++++++
 src/topology/pcm.c        |  4 ++--
 src/topology/tplg_local.h |  2 ++
 4 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.5.0
