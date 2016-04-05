From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/2] conf: topology: Add the conf for
	SKL-rt286
Date: Mon,  4 Apr 2016 22:20:03 -0700
Message-ID: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 09FD626170F
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 07:20:10 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The SKL RT286 I2S topology conf is provided here. The first patch adds that
along with binary data for modules.

The Second patch provides source of those binayy blobs and allows them to be
recompiled.

Shreyas NC (2):
  conf: topology: Add Skylake i2s conf
  conf: topology: Generate Private data binary blobs

 configure.ac                                       |    1 +
 src/conf/topology/Makefile.am                      |    2 +-
 src/conf/topology/sklrt286/Makefile.am             |    4 +
 src/conf/topology/sklrt286/codec0_in-cpr-1.bin     |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/codec0_in-mi.bin        |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/codec0_out-cpr-4.bin    |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/codec0_out-mo.bin       |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/codec1_out-cpr-5.bin    |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/codec1_out-mo.bin       |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/data/Makefile.am        |    4 +
 src/conf/topology/sklrt286/data/README             |    2 +
 src/conf/topology/sklrt286/data/compile_local      |   16 +
 src/conf/topology/sklrt286/data/configure.ac       |   30 +
 src/conf/topology/sklrt286/data/pvt.c              | 1815 ++++++++++++++++++++
 src/conf/topology/sklrt286/data/pvt_data.c         |   90 +
 src/conf/topology/sklrt286/data/pvt_data_local.h   |  115 ++
 .../topology/sklrt286/dmic01_hifi_in-cpr-3.bin     |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/dmic01_hifi_in-mi.bin   |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-7.bin  |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi1_pt_out-cpr-8.bin  |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-10.bin |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi2_pt_out-cpr-9.bin  |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-11.bin |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/hdmi3_pt_out-cpr-12.bin |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/media0_in-cpr-0.bin     |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/media0_in-mi.bin        |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/media0_out-cpr-6.bin    |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/media0_out-mo.bin       |  Bin 0 -> 4268 bytes
 src/conf/topology/sklrt286/skl_i2s.conf            |  342 ++++
 29 files changed, 2420 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/topology/sklrt286/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/codec0_in-cpr-1.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_in-mi.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_out-cpr-4.bin
 create mode 100644 src/conf/topology/sklrt286/codec0_out-mo.bin
 create mode 100644 src/conf/topology/sklrt286/codec1_out-cpr-5.bin
 create mode 100644 src/conf/topology/sklrt286/codec1_out-mo.bin
 create mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/README
 create mode 100755 src/conf/topology/sklrt286/data/compile_local
 create mode 100644 src/conf/topology/sklrt286/data/configure.ac
 create mode 100644 src/conf/topology/sklrt286/data/pvt.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data_local.h
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
2.4.11
