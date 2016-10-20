From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/3] topology: Support widgets' stream name
	and file inclusion for text conf file
Date: Thu, 20 Oct 2016 13:46:05 +0800
Message-ID: <cover.1476941614.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EE6B72666CF
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 07:45:03 +0200 (CEST)
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

Patch 1 fixes a missing topology feature for text conf file to configure
	stream name of a widget.

Patch 2 allows alsaconf to search included files under global
        configuration directories. This will benefit topology and UCM.

Patch 3 adds document about how to include files for topology
	configuration. There is no c code change but actually it depends
	on patch 2.

History:
v2: 	No longer use topology-specific code to support searching included
	files, but extend alsaconf to support this and user can just use
	alsaconf syntax <xxx> and <confdir:xxx>. 

Mengdong Lin (3):
  topology: Fix missing stream name of widgets in text conf file
  alsaconf: Search included files under global configuration directories
  topology: Add doc for including other files in the text conf file

 include/topology.h  |  31 ++++++++++++
 src/conf.c          | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/dapm.c |  10 ++++
 3 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.5.0
