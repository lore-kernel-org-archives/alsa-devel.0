From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/2] topology: Support widgets' stream name and
	file inclusion for text conf file
Date: Mon, 17 Oct 2016 13:55:21 +0800
Message-ID: <cover.1476683054.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C9A17261560
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 07:54:22 +0200 (CEST)
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

This series doesn't require or cause any ABI updates. It doesn't need the
kernel patches that trying to udpate ABI from v4 or v5.

It just fix a missing feature and enhance text conf file to support
including files to control the increasing size of text conf files.

Mengdong Lin (2):
  topology: Fix missing stream name of widgets in text conf file
  topology: Add support for included files

 include/topology.h        |  38 +++++
 src/topology/dapm.c       |  10 ++
 src/topology/parser.c     | 374 +++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/tplg_local.h |  17 +++
 4 files changed, 434 insertions(+), 5 deletions(-)

-- 
2.5.0
