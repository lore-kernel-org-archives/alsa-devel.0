From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 3/3] conf: topology: Generate Private data
	binary blobs
Date: Thu, 21 Apr 2016 11:57:38 +0530
Message-ID: <1461220058-1378-4-git-send-email-vinod.koul@intel.com>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 186F32604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:23:13 +0200 (CEST)
In-Reply-To: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The DSP modules need private data and that is provided as binary
blob. These blobs are compiled from C structures which specify module
configuration.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 configure.ac                                       |    1 +
 src/conf/topology/sklrt286/data/Makefile.am        |    6 +
 src/conf/topology/sklrt286/data/pvt.c              | 1815 ++++++++++++++++++++
 src/conf/topology/sklrt286/data/pvt_data.c         |   90 +
 src/conf/topology/sklrt286/data/pvt_local.h        |    9 +
 .../topology/sklrt286/data/skl-tplg-interface.h    |  232 +++
 6 files changed, 2153 insertions(+)
 create mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/pvt.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_local.h
 create mode 100644 src/conf/topology/sklrt286/data/skl-tplg-interface.h

diff --git a/configure.ac b/configure.ac
index 1bf75e6d9c2b..28fcd24a883d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -661,6 +661,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
+	  src/conf/topology/sklrt286/data/Makefile \
 	  src/conf/topology/sklrt286/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
diff --git a/src/conf/topology/sklrt286/data/Makefile.am b/src/conf/topology/sklrt286/data/Makefile.am
new file mode 100644
index 000000000000..1eb9b2e13b78
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/Makefile.am
@@ -0,0 +1,6 @@
+noinst_PROGRAMS = pvt_data
+pvt_data_SOURCES = pvt_data.c
+AM_CPPFLAGS = \
+         -Wall -I$(top_srcdir)/include
+install-exec-local:
+	./pvt_data
diff --git a/src/conf/topology/sklrt286/data/pvt.c b/src/conf/topology/sklrt286/data/pvt.c
new file mode 100644
index 000000000000..3447e3e0226b
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/pvt.c
@@ -0,0 +1,1815 @@
+/*
+* Copyright(c) 2014-2016 Intel Corporation
+* All rights reserved.
+*
+* This library is free software; you can redistribute it and/or
+* modify it under the terms of the GNU Lesser General Public
+* License as published by the Free Software Foundation; either
+* version 2 of the License, or (at your option) any later version.
+
+* This library is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+* General Public License for more details.
+*
+* Authors: Shreyas Nc <shreyas.nc@intel.com>
+*
+*/
+#include "pvt_local.h"
+
+struct skl_dfw_module_mod dfw_wrap[] = {
+{
+.name = "media0_in cpr 0",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 0,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 5,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 1,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "media0_in mi",
+.skl_dfw_mod = {
+	.uuid = {178, 110, 101, 57, 113, 59, 73, 64, 141, 63, 249, 44, 213, 196, 60, 9},
+	.module_id = 1,
+	.instance_id = 0,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 1,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "media0_out mo",
+.skl_dfw_mod = {
+	.uuid = {90, 80, 86, 60, 215, 36, 143, 65, 189, 220, 193, 245, 163, 172, 42, 224},
+	.module_id = 2,
+	.instance_id = 2,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 8,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 2,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "media0_out cpr 6",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 6,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 0,
+	.dev_type = 5,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 2,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec0_out mo",
+.skl_dfw_mod = {
+	.uuid = {90, 80, 86, 60, 215, 36, 143, 65, 189, 220, 193, 245, 163, 172, 42, 224},
+	.module_id = 2,
+	.instance_id = 0,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 8,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 3,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x4,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec0_out cpr 4",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 4,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = 0,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 2,
+	.dev_type = 2,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 3,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x4,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec1_out mo",
+.skl_dfw_mod = {
+	.uuid = {90, 80, 86, 60, 215, 36, 143, 65, 189, 220, 193, 245, 163, 172, 42, 224},
+	.module_id = 2,
+	.instance_id = 1,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 8,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 4,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec1_out cpr 5",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 5,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = 0,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 2,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 2,
+	.dev_type = 2,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 4,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec0_in cpr 1",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 1,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = 0,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 2,
+	.dev_type = 2,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 5,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "codec0_in mi",
+.skl_dfw_mod = {
+	.uuid = {178, 110, 101, 57, 113, 59, 73, 64, 141, 63, 249, 44, 213, 196, 60, 9},
+	.module_id = 1,
+	.instance_id = 1,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 5,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "dmic01_hifi_in cpr 3",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 3,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = 0,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 2,
+	.dev_type = 1,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 4,
+	.converter = 4,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 6,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "dmic01_hifi_in mi",
+.skl_dfw_mod = {
+	.uuid = {178, 110, 101, 57, 113, 59, 73, 64, 141, 63, 249, 44, 213, 196, 60, 9},
+	.module_id = 1,
+	.instance_id = 3,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 1,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 0,
+	.conn_type = 0,
+	.dev_type = 6,
+	.hw_conn_type = 2,
+	.rsvd2 = 0,
+	.params_fixup = 0,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 6,
+		.pipe_priority = 0,
+		.conn_type = 2,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi1_pt_out cpr 7",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 7,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 5,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 7,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi1_pt_out cpr 8",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 8,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 4,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 7,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi2_pt_out cpr 9",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 9,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 5,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 8,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi2_pt_out cpr 10",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 10,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 4,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 8,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi3_pt_out cpr 11",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 11,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 5,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 9,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 32,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+{
+.name = "hdmi3_pt_out cpr 12",
+.skl_dfw_mod = {
+	.uuid = {131, 12, 160, 155, 18, 202, 131, 74, 148, 60, 31, 162, 232, 47, 157, 218},
+	.module_id = 3,
+	.instance_id = 12,
+	.max_mcps = 0x186a0,
+	.mem_pages = 0x1,
+	.obs = 384,
+	.ibs = 384,
+	.vbus_id = -1,
+	.max_in_queue = 1,
+	.max_out_queue = 2,
+	.time_slot = 0,
+	.core_id = 0,
+	.rsvd1 = 0,
+	.module_type = 1,
+	.conn_type = 1,
+	.dev_type = 4,
+	.hw_conn_type = 1,
+	.rsvd2 = 0,
+	.params_fixup = 7,
+	.converter = 0,
+	.input_pin_type = 0,
+	.output_pin_type = 0,
+	.is_dynamic_in_pin = 1,
+	.is_dynamic_out_pin = 1,
+	.is_loadable = 0,
+	.rsvd3 = 0,
+	.pipe = {
+		.pipe_id = 9,
+		.pipe_priority = 0,
+		.conn_type = 1,
+		.rsvd = 0,
+		.memory_pages = 0x2,
+	},
+	.in_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.out_fmt = {
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+		{
+			.channels = 2,
+			.freq = 48000,
+			.bit_depth = 32,
+			.valid_bit_depth = 24,
+			.ch_cfg = 1,
+			.interleaving_style = 0,
+			.sample_type = 0,
+			.ch_map = 0xffffff10,
+		},
+	},
+	.in_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	.out_pin = {
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+		{
+			.module_id = 0,
+			.instance_id = 0,
+		},
+	},
+	},
+},
+	};
diff --git a/src/conf/topology/sklrt286/data/pvt_data.c b/src/conf/topology/sklrt286/data/pvt_data.c
new file mode 100644
index 000000000000..dd55c3a38b3b
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/pvt_data.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright(c) 2014-2016 Intel Corporation
+ * All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ * Authors: Shreyas Nc <shreyas.nc@intel.com>
+ *
+ */
+#include "pvt.c"
+#include "stdio.h"
+#include "fcntl.h"
+#include <local.h>
+#include <limits.h>
+#include <stdint.h>
+#include <linux/types.h>
+#include "global.h"
+#include "list.h"
+
+#include <sound/asound.h>
+#include <sound/asoc.h>
+
+int replace_space(char *path, char *newpath)
+{
+	char buffer[52];
+	char *p;
+
+	strcpy(buffer, path);
+
+	while ((p = strchr(buffer, ' ')))
+		p[0] = '-';
+
+	strcpy(newpath, buffer);
+	return 0;
+}
+
+/*
+ * The private data structures are written into a
+ * binary blob. These contain module private data
+ * information
+ */
+int main(void)
+{
+	unsigned int i;
+	FILE  *fd;
+	char path[128];
+	char new_path[128];
+	struct snd_soc_tplg_private *priv = NULL;
+
+	memset(path, 0, sizeof(path));
+	memset(new_path, 0, sizeof(new_path));
+
+	priv = calloc(1, sizeof(dfw_wrap) + sizeof(uint32_t));
+
+	for (i = 0; i < ARRAY_SIZE(dfw_wrap); i++) {
+		strcat(path, "../");
+		strcat(path, dfw_wrap[i].name);
+		strcat(path, ".bin");
+
+		replace_space(path, new_path);
+
+		priv->size = (uint32_t)sizeof(dfw_wrap[i].skl_dfw_mod);
+
+		memcpy(priv->data, &dfw_wrap[i].skl_dfw_mod,
+				priv->size);
+
+		fd = fopen(new_path, "wb");
+
+		if (fd == NULL)
+			return -ENOENT;
+
+		if (fwrite(priv->data, priv->size, 1, fd) != 1) {
+			fclose(fd);
+			return -1;
+		}
+
+		memset(path, 0, sizeof(path));
+	}
+
+	free(priv);
+	return 0;
+}
diff --git a/src/conf/topology/sklrt286/data/pvt_local.h b/src/conf/topology/sklrt286/data/pvt_local.h
new file mode 100644
index 000000000000..5edf7bd71ce9
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/pvt_local.h
@@ -0,0 +1,9 @@
+#include <stdio.h>
+#include "skl-tplg-interface.h"
+
+struct skl_dfw_module_mod {
+	char name[100];
+	struct skl_dfw_module skl_dfw_mod;
+};
+
+
diff --git a/src/conf/topology/sklrt286/data/skl-tplg-interface.h b/src/conf/topology/sklrt286/data/skl-tplg-interface.h
new file mode 100644
index 000000000000..c78e937ea968
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/skl-tplg-interface.h
@@ -0,0 +1,232 @@
+/*
+ * skl-tplg-interface.h - Intel DSP FW private data interface
+ *
+ * Copyright (C) 2015 Intel Corp
+ * Author: Jeeja KP <jeeja.kp@intel.com>
+ *	    Nilofer, Samreen <samreen.nilofer@intel.com>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __HDA_TPLG_INTERFACE_H__
+#define __HDA_TPLG_INTERFACE_H__
+
+#include <sound/type_compat.h>
+/*
+ * Default types range from 0~12. type can range from 0 to 0xff
+ * SST types start at higher to avoid any overlapping in future
+ */
+#define SKL_CONTROL_TYPE_BYTE_TLV	0x100
+
+#define HDA_SST_CFG_MAX	900 /* size of copier cfg*/
+#define MAX_IN_QUEUE 8
+#define MAX_OUT_QUEUE 8
+
+#define SKL_UUID_STR_SZ 40
+/* Event types goes here */
+/* Reserve event type 0 for no event handlers */
+enum skl_event_types {
+	SKL_EVENT_NONE = 0,
+	SKL_MIXER_EVENT,
+	SKL_MUX_EVENT,
+	SKL_VMIXER_EVENT,
+	SKL_PGA_EVENT
+};
+
+/**
+ * enum skl_ch_cfg - channel configuration
+ *
+ * @SKL_CH_CFG_MONO:	One channel only
+ * @SKL_CH_CFG_STEREO:	L & R
+ * @SKL_CH_CFG_2_1:	L, R & LFE
+ * @SKL_CH_CFG_3_0:	L, C & R
+ * @SKL_CH_CFG_3_1:	L, C, R & LFE
+ * @SKL_CH_CFG_QUATRO:	L, R, Ls & Rs
+ * @SKL_CH_CFG_4_0:	L, C, R & Cs
+ * @SKL_CH_CFG_5_0:	L, C, R, Ls & Rs
+ * @SKL_CH_CFG_5_1:	L, C, R, Ls, Rs & LFE
+ * @SKL_CH_CFG_DUAL_MONO: One channel replicated in two
+ * @SKL_CH_CFG_I2S_DUAL_STEREO_0: Stereo(L,R) in 4 slots, 1st stream:[ L, R, -, - ]
+ * @SKL_CH_CFG_I2S_DUAL_STEREO_1: Stereo(L,R) in 4 slots, 2nd stream:[ -, -, L, R ]
+ * @SKL_CH_CFG_INVALID:	Invalid
+ */
+enum skl_ch_cfg {
+	SKL_CH_CFG_MONO = 0,
+	SKL_CH_CFG_STEREO = 1,
+	SKL_CH_CFG_2_1 = 2,
+	SKL_CH_CFG_3_0 = 3,
+	SKL_CH_CFG_3_1 = 4,
+	SKL_CH_CFG_QUATRO = 5,
+	SKL_CH_CFG_4_0 = 6,
+	SKL_CH_CFG_5_0 = 7,
+	SKL_CH_CFG_5_1 = 8,
+	SKL_CH_CFG_DUAL_MONO = 9,
+	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
+	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
+	SKL_CH_CFG_4_CHANNEL = 12,
+	SKL_CH_CFG_INVALID
+};
+
+enum skl_module_type {
+	SKL_MODULE_TYPE_MIXER = 0,
+	SKL_MODULE_TYPE_COPIER,
+	SKL_MODULE_TYPE_UPDWMIX,
+	SKL_MODULE_TYPE_SRCINT,
+	SKL_MODULE_TYPE_ALGO,
+	SKL_MODULE_TYPE_BASE_OUTFMT
+};
+
+enum skl_core_affinity {
+	SKL_AFFINITY_CORE_0 = 0,
+	SKL_AFFINITY_CORE_1,
+	SKL_AFFINITY_CORE_MAX
+};
+
+enum skl_pipe_conn_type {
+	SKL_PIPE_CONN_TYPE_NONE = 0,
+	SKL_PIPE_CONN_TYPE_FE,
+	SKL_PIPE_CONN_TYPE_BE
+};
+
+enum skl_hw_conn_type {
+	SKL_CONN_NONE = 0,
+	SKL_CONN_SOURCE = 1,
+	SKL_CONN_SINK = 2
+};
+
+enum skl_dev_type {
+	SKL_DEVICE_BT = 0x0,
+	SKL_DEVICE_DMIC = 0x1,
+	SKL_DEVICE_I2S = 0x2,
+	SKL_DEVICE_SLIMBUS = 0x3,
+	SKL_DEVICE_HDALINK = 0x4,
+	SKL_DEVICE_HDAHOST = 0x5,
+	SKL_DEVICE_NONE
+};
+
+/**
+ * enum skl_interleaving - interleaving style
+ *
+ * @SKL_INTERLEAVING_PER_CHANNEL: [s1_ch1...s1_chN,...,sM_ch1...sM_chN]
+ * @SKL_INTERLEAVING_PER_SAMPLE: [s1_ch1...sM_ch1,...,s1_chN...sM_chN]
+ */
+enum skl_interleaving {
+	SKL_INTERLEAVING_PER_CHANNEL = 0,
+	SKL_INTERLEAVING_PER_SAMPLE = 1,
+};
+
+enum skl_sample_type {
+	SKL_SAMPLE_TYPE_INT_MSB = 0,
+	SKL_SAMPLE_TYPE_INT_LSB = 1,
+	SKL_SAMPLE_TYPE_INT_SIGNED = 2,
+	SKL_SAMPLE_TYPE_INT_UNSIGNED = 3,
+	SKL_SAMPLE_TYPE_FLOAT = 4
+};
+
+enum module_pin_type {
+	/* All pins of the module takes same PCM inputs or outputs
+	 * e.g. mixout
+	 */
+	SKL_PIN_TYPE_HOMOGENEOUS,
+	/* All pins of the module takes different PCM inputs or outputs
+	 * e.g mux
+	 */
+	SKL_PIN_TYPE_HETEROGENEOUS,
+};
+
+enum skl_module_param_type {
+	SKL_PARAM_DEFAULT = 0,
+	SKL_PARAM_INIT,
+	SKL_PARAM_SET,
+	SKL_PARAM_BIND
+};
+
+struct skl_dfw_module_pin {
+	__le16 module_id;
+	__le16 instance_id;
+} __attribute__((packed));
+
+struct skl_dfw_module_fmt {
+	__le32 channels;
+	__le32 freq;
+	__le32 bit_depth;
+	__le32 valid_bit_depth;
+	__le32 ch_cfg;
+	__le32 interleaving_style;
+	__le32 sample_type;
+	__le32 ch_map;
+} __attribute__((packed));
+
+struct skl_dfw_module_caps {
+	__le32 set_params:2;
+	__le32 rsvd:30;
+	__le32 param_id;
+	__le32 caps_size;
+	__le32 caps[HDA_SST_CFG_MAX];
+};
+
+struct skl_dfw_pipe {
+	__le8 pipe_id;
+	__le8 pipe_priority;
+	__le16 conn_type:4;
+	__le16 rsvd:4;
+	__le16 memory_pages:8;
+} __attribute__((packed));
+
+struct skl_dfw_module {
+	__le8 uuid[16];
+
+	__le16 module_id;
+	__le16 instance_id;
+	__le32 max_mcps;
+	__le32 mem_pages;
+	__le32 obs;
+	__le32 ibs;
+	__le32 vbus_id;
+
+	__le32 max_in_queue:8;
+	__le32 max_out_queue:8;
+	__le32 time_slot:8;
+	__le32 core_id:4;
+	__le32 rsvd1:4;
+
+	__le32 module_type:8;
+	__le32 conn_type:4;
+	__le32 dev_type:4;
+	__le32 hw_conn_type:4;
+	__le32 rsvd2:12;
+
+	__le32 params_fixup:8;
+	__le32 converter:8;
+	__le32 input_pin_type:1;
+	__le32 output_pin_type:1;
+	__le32 is_dynamic_in_pin:1;
+	__le32 is_dynamic_out_pin:1;
+	__le32 is_loadable:1;
+	__le32 rsvd3:11;
+
+	struct skl_dfw_pipe pipe;
+	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
+	struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
+	struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
+	struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
+	struct skl_dfw_module_caps caps;
+} __attribute__((packed));
+
+struct skl_dfw_algo_data {
+	__le32 set_params:2;
+	__le32 rsvd:30;
+	__le32 param_id;
+	__le32 max;
+	char params[0];
+} __attribute__((packed));
+
+#endif
-- 
1.9.1
