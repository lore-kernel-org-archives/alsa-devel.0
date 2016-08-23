From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH RESEND 0/3] conf: Add vendor tuples in conf
Date: Tue, 23 Aug 2016 09:38:33 +0530
Message-ID: <1471925316-490-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id BEE74266A6F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 06:00:48 +0200 (CEST)
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

Topology changes in alsa-lib allow driver data for modules to be be passed
in topology conf file using tuples. These changes allow private data to
represented by tuples of type UUID, byte, short, word and strings.

This patch series adds changes to :
 - include tuple and token list in the conf file
   to define module private data.
 - Private data blobs for modules are no longer required. So, remove the
   binary blobs and the tool used to generate the blobs.
 - Then add bxt conf file which is based on tuples

Shreyas NC (3):
  conf: sklrt286: define module private data through tuples in skylake
  conf: sklrt286: Remove tool to generate private data blobs
  conf: bxtrt298: Add topology conf file for bxt

 configure.ac                                       |    2 +-
 src/conf/topology/Makefile.am                      |    2 +-
 src/conf/topology/bxtrt298/Makefile.am             |    4 +
 src/conf/topology/bxtrt298/bxt_i2s.conf            | 3323 ++++++++++++++++++++
 src/conf/topology/sklrt286/Makefile.am             |    3 +-
 src/conf/topology/sklrt286/codec0_in-cpr-1.bin     |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/codec0_in-mi.bin        |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/codec0_out-cpr-4.bin    |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/codec0_out-mo.bin       |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/codec1_out-cpr-5.bin    |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/codec1_out-mo.bin       |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/data/Makefile.am        |    6 -
 src/conf/topology/sklrt286/data/pvt.c              | 1815 -----------
 src/conf/topology/sklrt286/data/pvt_data.c         |   90 -
 src/conf/topology/sklrt286/data/pvt_local.h        |    9 -
 .../topology/sklrt286/data/skl-tplg-interface.h    |  232 --
 .../topology/sklrt286/dmic01_hifi_in-cpr-3.bin     |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/dmic01_hifi_in-mi.bin   |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-7.bin  |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-8.bin  |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-10.bin |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-9.bin  |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-11.bin |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-12.bin |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/media0_in-cpr-0.bin     |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/media0_in-mi.bin        |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/media0_out-cpr-6.bin    |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/media0_out-mo.bin       |  Bin 4244 -> 0 bytes
 src/conf/topology/sklrt286/skl_i2s.conf            | 2694 +++++++++++++++-
 29 files changed, 5988 insertions(+), 2192 deletions(-)
 create mode 100644 src/conf/topology/bxtrt298/Makefile.am
 create mode 100644 src/conf/topology/bxtrt298/bxt_i2s.conf
 delete mode 100644 src/conf/topology/sklrt286/codec0_in-cpr-1.bin
 delete mode 100644 src/conf/topology/sklrt286/codec0_in-mi.bin
 delete mode 100644 src/conf/topology/sklrt286/codec0_out-cpr-4.bin
 delete mode 100644 src/conf/topology/sklrt286/codec0_out-mo.bin
 delete mode 100644 src/conf/topology/sklrt286/codec1_out-cpr-5.bin
 delete mode 100644 src/conf/topology/sklrt286/codec1_out-mo.bin
 delete mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 delete mode 100644 src/conf/topology/sklrt286/data/pvt.c
 delete mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 delete mode 100644 src/conf/topology/sklrt286/data/pvt_local.h
 delete mode 100644 src/conf/topology/sklrt286/data/skl-tplg-interface.h
 delete mode 100644 src/conf/topology/sklrt286/dmic01_hifi_in-cpr-3.bin
 delete mode 100644 src/conf/topology/sklrt286/dmic01_hifi_in-mi.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-7.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-8.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-10.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-9.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-11.bin
 delete mode 100644 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-12.bin
 delete mode 100644 src/conf/topology/sklrt286/media0_in-cpr-0.bin
 delete mode 100644 src/conf/topology/sklrt286/media0_in-mi.bin
 delete mode 100644 src/conf/topology/sklrt286/media0_out-cpr-6.bin
 delete mode 100644 src/conf/topology/sklrt286/media0_out-mo.bin

-- 
1.9.1
