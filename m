From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-audmux: change snprintf to
	scnprintf for possible overflow" to the asoc tree
Date: Tue, 15 Jan 2019 19:08:19 +0000 (GMT)
Message-ID: <20190115190819.3C14B1127848@debutante.sirena.org.uk>
References: <20190115032727.GA6440@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 12533266ABE
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 20:08:21 +0100 (CET)
In-Reply-To: <20190115032727.GA6440@1wt.eu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Silvio Cesare <silvio.cesare@gmail.com>
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Greg KH <greg@kroah.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Willy Tarreau <w@1wt.eu>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

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

>From c407cd008fd039320d147088b52d0fa34ed3ddcb Mon Sep 17 00:00:00 2001
From: Silvio Cesare <silvio.cesare@gmail.com>
Date: Tue, 15 Jan 2019 04:27:27 +0100
Subject: [PATCH] ASoC: imx-audmux: change snprintf to scnprintf for possible
 overflow

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 392d5eef356d..99e07b01a2ce 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
+	ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS output from %s, ",
 				audmux_port_string((ptcr >> 27) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS input, ");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk output from %s",
 				audmux_port_string((ptcr >> 22) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk input");
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"Port is symmetric");
 	} else {
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS output from %s, ",
 					audmux_port_string((ptcr >> 17) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS input, ");
 
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk output from %s",
 					audmux_port_string((ptcr >> 12) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk input");
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret,
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 			"\nData received from %s\n",
 			audmux_port_string((pdcr >> 13) & 0x7));
 
-- 
2.20.1
