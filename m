From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 0/3]: conf: topology: Add the conf for
	SKL-rt286
Date: Thu, 28 Apr 2016 11:07:55 +0530
Message-ID: <1461821878-26953-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BCE2650DA
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 07:32:20 +0200 (CEST)
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

Changes in v4:
 - add back the pre-compiled binary blobs
 - remove running the binary on intsall step

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
 src/conf/topology/sklrt286/Makefile.am             |    5 +
 src/conf/topology/sklrt286/codec0_in-cpr-1.bin     |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/codec0_in-mi.bin        |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/codec0_out-cpr-4.bin    |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/codec0_out-mo.bin       |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/codec1_out-cpr-5.bin    |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/codec1_out-mo.bin       |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/data/Makefile.am        |    4 +
 src/conf/topology/sklrt286/data/pvt.c              | 1815 ++++++++++++++++++++
 src/conf/topology/sklrt286/data/pvt_data.c         |   90 +
 src/conf/topology/sklrt286/data/pvt_local.h        |    9 +
 .../topology/sklrt286/data/skl-tplg-interface.h    |  232 +++
 .../topology/sklrt286/dmic01_hifi_in-cpr-3.bin     |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/dmic01_hifi_in-mi.bin   |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-7.bin  |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-8.bin  |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-10.bin |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-9.bin  |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-11.bin |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-12.bin |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/media0_in-cpr-0.bin     |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/media0_in-mi.bin        |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/media0_out-cpr-6.bin    |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/media0_out-mo.bin       |  Bin 0 -> 4244 bytes
 src/conf/topology/sklrt286/skl_i2s.conf            |  342 ++++
 28 files changed, 2502 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/topology/sklrt286/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/codec0_in-cpr-1.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_in-mi.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_out-cpr-4.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_out-mo.bin
 create mode 100644 src/conf/topology/sklrt286/codec1_out-cpr-5.bin
 create mode 100644 src/conf/topology/sklrt286/codec1_out-mo.bin
 create mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/pvt.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_local.h
 create mode 100644 src/conf/topology/sklrt286/data/skl-tplg-interface.h
 create mode 100644 src/conf/topology/sklrt286/dmic01_hifi_in-cpr-3.bin
 create mode 100644 src/conf/topology/sklrt286/dmic01_hifi_in-mi.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-7.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-8.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-10.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-9.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-11.bin
 create mode 100644 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-12.bin
 create mode 100644 src/conf/topology/sklrt286/media0_in-cpr-0.bin
 create mode 100644 src/conf/topology/sklrt286/media0_in-mi.bin
 create mode 100644 src/conf/topology/sklrt286/media0_out-cpr-6.bin
 create mode 100644 src/conf/topology/sklrt286/media0_out-mo.bin
 create mode 100644 src/conf/topology/sklrt286/skl_i2s.conf

-- 
1.9.1
