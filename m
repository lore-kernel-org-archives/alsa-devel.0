From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Sun, 20 Dec 2015 21:33:00 +0100
Message-ID: <5677107C.60904@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no guarantee that on fsl_ssi module load
SSI registers will have their power-on-reset values.

In fact, if the driver is reloaded the values in
registers will be whatever they were set to previously.

This fixes hard lockup on fsl_ssi module reload,
at least in AC'97 mode.

Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 40dfd8a36484..f6ef7d64acb3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -112,20 +112,6 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val tx;
 };
 
-static const struct reg_default fsl_ssi_reg_defaults[] = {
-	{CCSR_SSI_SCR,     0x00000000},
-	{CCSR_SSI_SIER,    0x00003003},
-	{CCSR_SSI_STCR,    0x00000200},
-	{CCSR_SSI_SRCR,    0x00000200},
-	{CCSR_SSI_STCCR,   0x00040000},
-	{CCSR_SSI_SRCCR,   0x00040000},
-	{CCSR_SSI_SACNT,   0x00000000},
-	{CCSR_SSI_STMSK,   0x00000000},
-	{CCSR_SSI_SRMSK,   0x00000000},
-	{CCSR_SSI_SACCEN,  0x00000000},
-	{CCSR_SSI_SACCDIS, 0x00000000},
-};
-
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -190,8 +176,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.reg_defaults = fsl_ssi_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
