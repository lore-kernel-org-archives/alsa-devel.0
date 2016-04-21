From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/3] conf: topology: Add the conf for
	SKL-rt286
Date: Thu, 21 Apr 2016 11:57:35 +0530
Message-ID: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F45260711
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:23:05 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This series adds SKL-i2c conf for simple PCM  topology graph

Changes in v3:

 - remove bin blobs, now they are generated in install step
 - hook the tool compilation to alsa-lib and run it on install
 - add u8 in alsa type_compat.h

Shreyas NC (3):
  conf: topology: Add Skylake i2s conf
  Add u8 in type_compat.h
  conf: topology: Generate Private data binary blobs

 configure.ac                                       |    2 +
 include/sound/type_compat.h                        |    2 +
 src/conf/topology/Makefile.am                      |    2 +-
 src/conf/topology/sklrt286/Makefile.am             |   11 +
 src/conf/topology/sklrt286/data/Makefile.am        |    6 +
 src/conf/topology/sklrt286/data/pvt.c              | 1815 ++++++++++++++++++++
 src/conf/topology/sklrt286/data/pvt_data.c         |   90 +
 src/conf/topology/sklrt286/data/pvt_local.h        |    9 +
 .../topology/sklrt286/data/skl-tplg-interface.h    |  232 +++
 src/conf/topology/sklrt286/skl_i2s.conf            |  342 ++++
 10 files changed, 2510 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/topology/sklrt286/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/pvt.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_local.h
 create mode 100644 src/conf/topology/sklrt286/data/skl-tplg-interface.h
 create mode 100644 src/conf/topology/sklrt286/skl_i2s.conf

-- 
1.9.1
