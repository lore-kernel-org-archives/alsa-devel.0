From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/2] conf: topology: Generate Private data
	binary blobs
Date: Mon,  4 Apr 2016 22:20:05 -0700
Message-ID: <1459833605-11223-3-git-send-email-vinod.koul@intel.com>
References: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 225C4261A03
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 07:20:12 +0200 (CEST)
In-Reply-To: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
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
 src/conf/topology/sklrt286/data/Makefile.am      |    4 +
 src/conf/topology/sklrt286/data/README           |    2 +
 src/conf/topology/sklrt286/data/compile_local    |   16 +
 src/conf/topology/sklrt286/data/configure.ac     |   30 +
 src/conf/topology/sklrt286/data/pvt.c            | 1815 ++++++++++++++++++++++
 src/conf/topology/sklrt286/data/pvt_data.c       |   90 ++
 src/conf/topology/sklrt286/data/pvt_data_local.h |  115 ++
 7 files changed, 2072 insertions(+)
 create mode 100644 src/conf/topology/sklrt286/data/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/data/README
 create mode 100755 src/conf/topology/sklrt286/data/compile_local
 create mode 100644 src/conf/topology/sklrt286/data/configure.ac
 create mode 100644 src/conf/topology/sklrt286/data/pvt.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data.c
 create mode 100644 src/conf/topology/sklrt286/data/pvt_data_local.h

diff --git a/src/conf/topology/sklrt286/data/Makefile.am b/src/conf/topology/sklrt286/data/Makefile.am
new file mode 100644
index 000000000000..9898b9808055
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/Makefile.am
@@ -0,0 +1,4 @@
+bin_PROGRAMS = pvt_data
+pvt_data_SOURCES = pvt_data.c
+AM_CPPFLAGS = \
+         -Wall -I../../../../../include
diff --git a/src/conf/topology/sklrt286/data/README b/src/conf/topology/sklrt286/data/README
new file mode 100644
index 000000000000..7d1261069dae
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/README
@@ -0,0 +1,2 @@
+To compile the src file, run ./compile_local and then ./pvt_data to execute the binary.
+The private data blobs will be generated in the sklrt286 folder.
diff --git a/src/conf/topology/sklrt286/data/compile_local b/src/conf/topology/sklrt286/data/compile_local
new file mode 100755
index 000000000000..4b935f8b760d
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/compile_local
@@ -0,0 +1,16 @@
+#Helper script to compile
+touch ltconfig NEWS README AUTHORS ChangeLog
+libtoolize --force --copy --automake
+aclocal $ACLOCAL_FLAGS
+autoheader
+automake --foreign --copy --add-missing
+touch depcomp		# seems to be missing for old automake
+autoconf
+export CFLAGS='-O2 -Wall -W -pipe -g'
+echo "CFLAGS=$CFLAGS"
+echo "./configure $args"
+./configure $args || exit 1
+unset CFLAGS
+if [ -z "$GITCOMPILE_NO_MAKE" ]; then
+  make
+fi
diff --git a/src/conf/topology/sklrt286/data/configure.ac b/src/conf/topology/sklrt286/data/configure.ac
new file mode 100644
index 000000000000..72c9021edeaf
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/configure.ac
@@ -0,0 +1,30 @@
+#                                               -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+
+AC_PREREQ([2.69])
+AC_INIT(pvt_data, [VERSION], [BUG-REPORT-ADDRESS])
+AM_INIT_AUTOMAKE(pvt_data, 2.6)
+AC_CONFIG_SRCDIR([pvt_data.c])
+AC_CONFIG_HEADERS([])
+
+# Checks for programs.
+AC_PROG_CC
+
+# Checks for libraries.
+
+# Checks for header files.
+AC_CHECK_HEADERS([limits.h stdint.h])
+
+# Checks for typedefs, structures, and compiler characteristics.
+AC_TYPE_INT16_T
+AC_TYPE_INT32_T
+AC_TYPE_INT8_T
+AC_TYPE_UINT16_T
+AC_TYPE_UINT32_T
+AC_TYPE_UINT8_T
+
+# Checks for library functions.
+AC_CHECK_FUNCS([memset strchr])
+AC_CONFIG_FILES([Makefile])
+
+AC_OUTPUT
diff --git a/src/conf/topology/sklrt286/data/pvt.c b/src/conf/topology/sklrt286/data/pvt.c
new file mode 100644
index 000000000000..1f18eec5ec1a
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/pvt.c
@@ -0,0 +1,1815 @@
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
+#include "pvt_data_local.h"
+
+struct skl_dfw_module_mod dfw_wrap[] = {
+{
+.name = "media0_in cpr 0",
+.skl_dfw_mod = {
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "39656EB2-3B71-4049-8D3F-F92CD5C43C09",
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
+	.uuid = "3C56505A-24D7-418F-BDDC-C1F5A3AC2AE0",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "3C56505A-24D7-418F-BDDC-C1F5A3AC2AE0",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "3C56505A-24D7-418F-BDDC-C1F5A3AC2AE0",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "39656EB2-3B71-4049-8D3F-F92CD5C43C09",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.uuid = "39656EB2-3B71-4049-8D3F-F92CD5C43C09",
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
+	.uuid = "9BA00C83-CA12-4A83-943C-1FA2E82F9DDA",
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
+	.params_fixup = 0,
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
index 000000000000..cb6fc6ecd01e
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
+#include <limits.h>
+#include <stdint.h>
+#include <linux/types.h>
+#include "global.h"
+#include "local.h"
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
+int main()
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
diff --git a/src/conf/topology/sklrt286/data/pvt_data_local.h b/src/conf/topology/sklrt286/data/pvt_data_local.h
new file mode 100644
index 000000000000..72be7093bf9b
--- /dev/null
+++ b/src/conf/topology/sklrt286/data/pvt_data_local.h
@@ -0,0 +1,115 @@
+/*
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ */
+
+#ifndef __HDA_TPLG_INTERFACE_H__
+#define __HDA_TPLG_INTERFACE_H__
+
+#include <stdint.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#define SOC_CONTROL_TYPE_SKL_TLV_BYTE		0x100
+
+#define HDA_SST_CFG_MAX	900 /* max size of module init params */
+#define MAX_IN_QUEUE 8
+#define MAX_OUT_QUEUE 8
+
+#define SKL_UUID_STR_SZ 40
+
+struct skl_dfw_module_pin {
+	uint16_t module_id;
+	uint16_t instance_id;
+} __packed;
+
+struct skl_dfw_module_fmt {
+	uint32_t channels;
+	uint32_t freq;
+	uint32_t bit_depth;
+	uint32_t valid_bit_depth;
+	uint32_t ch_cfg;
+	uint32_t interleaving_style;
+	uint32_t sample_type;
+	uint32_t ch_map;
+} __packed;
+
+struct skl_dfw_module_caps {
+	uint32_t set_params:2;
+	uint32_t rsvd:30;
+	uint32_t param_id;
+	uint32_t caps_size;
+	uint32_t caps[HDA_SST_CFG_MAX];
+};
+
+struct skl_dfw_pipe {
+	uint8_t pipe_id;
+	uint8_t pipe_priority;
+	uint16_t conn_type:4;
+	uint16_t rsvd:4;
+	uint16_t memory_pages:8;
+} __packed;
+
+struct skl_dfw_module {
+	char uuid[SKL_UUID_STR_SZ];
+
+	uint16_t module_id;
+	uint16_t instance_id;
+	uint32_t max_mcps;
+	uint32_t mem_pages;
+	uint32_t obs;
+	uint32_t ibs;
+	uint32_t vbus_id;
+
+	uint32_t max_in_queue:8;
+	uint32_t max_out_queue:8;
+	uint32_t time_slot:8;
+	uint32_t core_id:4;
+	uint32_t rsvd1:4;
+
+	uint32_t module_type:8;
+	uint32_t conn_type:4;
+	uint32_t dev_type:4;
+	uint32_t hw_conn_type:4;
+	uint32_t rsvd2:12;
+
+	uint32_t params_fixup:8;
+	uint32_t converter:8;
+	uint32_t input_pin_type:1;
+	uint32_t output_pin_type:1;
+	uint32_t is_dynamic_in_pin:1;
+	uint32_t is_dynamic_out_pin:1;
+	uint32_t is_loadable:1;
+	uint32_t rsvd3:11;
+
+	struct skl_dfw_pipe pipe;
+	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
+	struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
+	struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
+	struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
+	struct skl_dfw_module_caps caps;
+} __packed;
+
+struct skl_dfw_algo_data {
+	uint32_t set_params:2;
+	uint32_t runtime_applicable:1;
+	uint32_t rsvd:29;
+	uint32_t param_id;
+	uint32_t max;
+	char params[0];
+} __packed;
+
+struct skl_dfw_module_mod {
+	char name[100];
+	struct skl_dfw_module skl_dfw_mod;
+};
+#endif
-- 
2.4.11
