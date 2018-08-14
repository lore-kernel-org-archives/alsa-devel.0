From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uapi: fix sound/skl-tplg-interface.h
	userspace compilation errors" to the asoc tree
Date: Tue, 14 Aug 2018 15:25:14 +0100 (BST)
Message-ID: <20180814142514.DF0231124449@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E68E926770B
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 16:25:15 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation errors

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fb504caae7ef85be159743bd4b08ecde269ba55f Mon Sep 17 00:00:00 2001
From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Mon, 13 Aug 2018 18:50:02 +0300
Subject: [PATCH] ASoC: uapi: fix sound/skl-tplg-interface.h userspace
 compilation errors

Include <linux/types.h> and consistently use types it provides
to fix the following sound/skl-tplg-interface.h userspace compilation errors:

/usr/include/sound/skl-tplg-interface.h:146:2: error: unknown type name 'u32'
  u32 set_params:2;
/usr/include/sound/skl-tplg-interface.h:147:2: error: unknown type name 'u32'
  u32 rsvd:30;
/usr/include/sound/skl-tplg-interface.h:148:2: error: unknown type name 'u32'
  u32 param_id;
/usr/include/sound/skl-tplg-interface.h:149:2: error: unknown type name 'u32'
  u32 max;
/usr/include/sound/skl-tplg-interface.h:166:2: error: unknown type name 'u16'
  u16 module_id;
/usr/include/sound/skl-tplg-interface.h:167:2: error: unknown type name 'u16'
  u16 instance_id;
/usr/include/sound/skl-tplg-interface.h:171:2: error: unknown type name 'u32'
  u32 channels;
/usr/include/sound/skl-tplg-interface.h:172:2: error: unknown type name 'u32'
  u32 freq;
/usr/include/sound/skl-tplg-interface.h:173:2: error: unknown type name 'u32'
  u32 bit_depth;
/usr/include/sound/skl-tplg-interface.h:174:2: error: unknown type name 'u32'
  u32 valid_bit_depth;
/usr/include/sound/skl-tplg-interface.h:175:2: error: unknown type name 'u32'
  u32 ch_cfg;
/usr/include/sound/skl-tplg-interface.h:176:2: error: unknown type name 'u32'
  u32 interleaving_style;
/usr/include/sound/skl-tplg-interface.h:177:2: error: unknown type name 'u32'
  u32 sample_type;
/usr/include/sound/skl-tplg-interface.h:178:2: error: unknown type name 'u32'
  u32 ch_map;
/usr/include/sound/skl-tplg-interface.h:182:2: error: unknown type name 'u32'
  u32 set_params:2;
/usr/include/sound/skl-tplg-interface.h:183:2: error: unknown type name 'u32'
  u32 rsvd:30;
/usr/include/sound/skl-tplg-interface.h:184:2: error: unknown type name 'u32'
  u32 param_id;
/usr/include/sound/skl-tplg-interface.h:185:2: error: unknown type name 'u32'
  u32 caps_size;
/usr/include/sound/skl-tplg-interface.h:186:2: error: unknown type name 'u32'
  u32 caps[HDA_SST_CFG_MAX];
/usr/include/sound/skl-tplg-interface.h:190:2: error: unknown type name 'u8'
  u8 pipe_id;
/usr/include/sound/skl-tplg-interface.h:191:2: error: unknown type name 'u8'
  u8 pipe_priority;
/usr/include/sound/skl-tplg-interface.h:192:2: error: unknown type name 'u16'
  u16 conn_type:4;
/usr/include/sound/skl-tplg-interface.h:193:2: error: unknown type name 'u16'
  u16 rsvd:4;
/usr/include/sound/skl-tplg-interface.h:194:2: error: unknown type name 'u16'
  u16 memory_pages:8;
/usr/include/sound/skl-tplg-interface.h:200:2: error: unknown type name 'u16'
  u16 module_id;
/usr/include/sound/skl-tplg-interface.h:201:2: error: unknown type name 'u16'
  u16 instance_id;
/usr/include/sound/skl-tplg-interface.h:202:2: error: unknown type name 'u32'
  u32 max_mcps;
/usr/include/sound/skl-tplg-interface.h:203:2: error: unknown type name 'u32'
  u32 mem_pages;
/usr/include/sound/skl-tplg-interface.h:204:2: error: unknown type name 'u32'
  u32 obs;
/usr/include/sound/skl-tplg-interface.h:205:2: error: unknown type name 'u32'
  u32 ibs;
/usr/include/sound/skl-tplg-interface.h:206:2: error: unknown type name 'u32'
  u32 vbus_id;
/usr/include/sound/skl-tplg-interface.h:208:2: error: unknown type name 'u32'
  u32 max_in_queue:8;
/usr/include/sound/skl-tplg-interface.h:209:2: error: unknown type name 'u32'
  u32 max_out_queue:8;
/usr/include/sound/skl-tplg-interface.h:210:2: error: unknown type name 'u32'
  u32 time_slot:8;
/usr/include/sound/skl-tplg-interface.h:211:2: error: unknown type name 'u32'
  u32 core_id:4;
/usr/include/sound/skl-tplg-interface.h:212:2: error: unknown type name 'u32'
  u32 rsvd1:4;
/usr/include/sound/skl-tplg-interface.h:214:2: error: unknown type name 'u32'
  u32 module_type:8;
/usr/include/sound/skl-tplg-interface.h:215:2: error: unknown type name 'u32'
  u32 conn_type:4;
/usr/include/sound/skl-tplg-interface.h:216:2: error: unknown type name 'u32'
  u32 dev_type:4;
/usr/include/sound/skl-tplg-interface.h:217:2: error: unknown type name 'u32'
  u32 hw_conn_type:4;
/usr/include/sound/skl-tplg-interface.h:218:2: error: unknown type name 'u32'
  u32 rsvd2:12;
/usr/include/sound/skl-tplg-interface.h:220:2: error: unknown type name 'u32'
  u32 params_fixup:8;
/usr/include/sound/skl-tplg-interface.h:221:2: error: unknown type name 'u32'
  u32 converter:8;
/usr/include/sound/skl-tplg-interface.h:222:2: error: unknown type name 'u32'
  u32 input_pin_type:1;
/usr/include/sound/skl-tplg-interface.h:223:2: error: unknown type name 'u32'
  u32 output_pin_type:1;
/usr/include/sound/skl-tplg-interface.h:224:2: error: unknown type name 'u32'
  u32 is_dynamic_in_pin:1;
/usr/include/sound/skl-tplg-interface.h:225:2: error: unknown type name 'u32'
  u32 is_dynamic_out_pin:1;
/usr/include/sound/skl-tplg-interface.h:226:2: error: unknown type name 'u32'
  u32 is_loadable:1;
/usr/include/sound/skl-tplg-interface.h:227:2: error: unknown type name 'u32'
  u32 rsvd3:11;

Fixes: 0c24fdc00244 ("ASoC: topology: Move skl-tplg-interface.h to uapi")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # v4.18
---
 include/uapi/sound/skl-tplg-interface.h | 106 ++++++++++++------------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
index f58cafa42f18..f39352cef382 100644
--- a/include/uapi/sound/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -10,6 +10,8 @@
 #ifndef __HDA_TPLG_INTERFACE_H__
 #define __HDA_TPLG_INTERFACE_H__
 
+#include <linux/types.h>
+
 /*
  * Default types range from 0~12. type can range from 0 to 0xff
  * SST types start at higher to avoid any overlapping in future
@@ -143,10 +145,10 @@ enum skl_module_param_type {
 };
 
 struct skl_dfw_algo_data {
-	u32 set_params:2;
-	u32 rsvd:30;
-	u32 param_id;
-	u32 max;
+	__u32 set_params:2;
+	__u32 rsvd:30;
+	__u32 param_id;
+	__u32 max;
 	char params[0];
 } __packed;
 
@@ -163,68 +165,68 @@ enum skl_tuple_type {
 /* v4 configuration data */
 
 struct skl_dfw_v4_module_pin {
-	u16 module_id;
-	u16 instance_id;
+	__u16 module_id;
+	__u16 instance_id;
 } __packed;
 
 struct skl_dfw_v4_module_fmt {
-	u32 channels;
-	u32 freq;
-	u32 bit_depth;
-	u32 valid_bit_depth;
-	u32 ch_cfg;
-	u32 interleaving_style;
-	u32 sample_type;
-	u32 ch_map;
+	__u32 channels;
+	__u32 freq;
+	__u32 bit_depth;
+	__u32 valid_bit_depth;
+	__u32 ch_cfg;
+	__u32 interleaving_style;
+	__u32 sample_type;
+	__u32 ch_map;
 } __packed;
 
 struct skl_dfw_v4_module_caps {
-	u32 set_params:2;
-	u32 rsvd:30;
-	u32 param_id;
-	u32 caps_size;
-	u32 caps[HDA_SST_CFG_MAX];
+	__u32 set_params:2;
+	__u32 rsvd:30;
+	__u32 param_id;
+	__u32 caps_size;
+	__u32 caps[HDA_SST_CFG_MAX];
 } __packed;
 
 struct skl_dfw_v4_pipe {
-	u8 pipe_id;
-	u8 pipe_priority;
-	u16 conn_type:4;
-	u16 rsvd:4;
-	u16 memory_pages:8;
+	__u8 pipe_id;
+	__u8 pipe_priority;
+	__u16 conn_type:4;
+	__u16 rsvd:4;
+	__u16 memory_pages:8;
 } __packed;
 
 struct skl_dfw_v4_module {
 	char uuid[SKL_UUID_STR_SZ];
 
-	u16 module_id;
-	u16 instance_id;
-	u32 max_mcps;
-	u32 mem_pages;
-	u32 obs;
-	u32 ibs;
-	u32 vbus_id;
-
-	u32 max_in_queue:8;
-	u32 max_out_queue:8;
-	u32 time_slot:8;
-	u32 core_id:4;
-	u32 rsvd1:4;
-
-	u32 module_type:8;
-	u32 conn_type:4;
-	u32 dev_type:4;
-	u32 hw_conn_type:4;
-	u32 rsvd2:12;
-
-	u32 params_fixup:8;
-	u32 converter:8;
-	u32 input_pin_type:1;
-	u32 output_pin_type:1;
-	u32 is_dynamic_in_pin:1;
-	u32 is_dynamic_out_pin:1;
-	u32 is_loadable:1;
-	u32 rsvd3:11;
+	__u16 module_id;
+	__u16 instance_id;
+	__u32 max_mcps;
+	__u32 mem_pages;
+	__u32 obs;
+	__u32 ibs;
+	__u32 vbus_id;
+
+	__u32 max_in_queue:8;
+	__u32 max_out_queue:8;
+	__u32 time_slot:8;
+	__u32 core_id:4;
+	__u32 rsvd1:4;
+
+	__u32 module_type:8;
+	__u32 conn_type:4;
+	__u32 dev_type:4;
+	__u32 hw_conn_type:4;
+	__u32 rsvd2:12;
+
+	__u32 params_fixup:8;
+	__u32 converter:8;
+	__u32 input_pin_type:1;
+	__u32 output_pin_type:1;
+	__u32 is_dynamic_in_pin:1;
+	__u32 is_dynamic_out_pin:1;
+	__u32 is_loadable:1;
+	__u32 rsvd3:11;
 
 	struct skl_dfw_v4_pipe pipe;
 	struct skl_dfw_v4_module_fmt in_fmt[MAX_IN_QUEUE];
-- 
2.18.0
