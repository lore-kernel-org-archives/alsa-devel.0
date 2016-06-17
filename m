From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ALSA: ctxfi: Change structure initialisation to C99 style
Date: Fri, 17 Jun 2016 20:15:54 +0530
Message-ID: <20160617144554.GA17407@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr, michael.leibowitz@intel.com, keescook@chromium.org
List-Id: alsa-devel@alsa-project.org

For readability and to allow for structure randomisation, replace the
in order struct initialisation style with explicit field style.

The Coccinelle semantic patch used to make this change is as follows:

@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@@
identifier decl.i1,i2,decl.fld;
expression e;
position bad.p, bad.fix;
@@

struct i1 i2@p = { ...,
+ .fld = e
- e@fix
 ,...};

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/pci/ctxfi/cthw20k2.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 9dc2950..6414ecf 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -1615,23 +1615,23 @@ static int hw_dac_init(struct hw *hw, const struct dac_conf *info)
 	int i;
 	struct regs_cs4382 cs_read = {0};
 	struct regs_cs4382 cs_def = {
-				   0x00000001,  /* Mode Control 1 */
-				   0x00000000,  /* Mode Control 2 */
-				   0x00000084,  /* Mode Control 3 */
-				   0x00000000,  /* Filter Control */
-				   0x00000000,  /* Invert Control */
-				   0x00000024,  /* Mixing Control Pair 1 */
-				   0x00000000,  /* Vol Control A1 */
-				   0x00000000,  /* Vol Control B1 */
-				   0x00000024,  /* Mixing Control Pair 2 */
-				   0x00000000,  /* Vol Control A2 */
-				   0x00000000,  /* Vol Control B2 */
-				   0x00000024,  /* Mixing Control Pair 3 */
-				   0x00000000,  /* Vol Control A3 */
-				   0x00000000,  /* Vol Control B3 */
-				   0x00000024,  /* Mixing Control Pair 4 */
-				   0x00000000,  /* Vol Control A4 */
-				   0x00000000   /* Vol Control B4 */
+		.mode_control_1 = 0x00000001, /* Mode Control 1 */
+		.mode_control_2 = 0x00000000, /* Mode Control 2 */
+		.mode_control_3 = 0x00000084, /* Mode Control 3 */
+		.filter_control = 0x00000000, /* Filter Control */
+		.invert_control = 0x00000000, /* Invert Control */
+		.mix_control_P1 = 0x00000024, /* Mixing Control Pair 1 */
+		.vol_control_A1 = 0x00000000, /* Vol Control A1 */
+		.vol_control_B1 = 0x00000000, /* Vol Control B1 */
+		.mix_control_P2 = 0x00000024, /* Mixing Control Pair 2 */
+		.vol_control_A2 = 0x00000000, /* Vol Control A2 */
+		.vol_control_B2 = 0x00000000, /* Vol Control B2 */
+		.mix_control_P3 = 0x00000024, /* Mixing Control Pair 3 */
+		.vol_control_A3 = 0x00000000, /* Vol Control A3 */
+		.vol_control_B3 = 0x00000000, /* Vol Control B3 */
+		.mix_control_P4 = 0x00000024, /* Mixing Control Pair 4 */
+		.vol_control_A4 = 0x00000000, /* Vol Control A4 */
+		.vol_control_B4 = 0x00000000  /* Vol Control B4 */
 				 };
 
 	if (hw->model == CTSB1270) {
-- 
1.9.1
