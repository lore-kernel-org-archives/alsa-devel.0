From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-git] ASoC: fix davinci-sffsdr buglet
Date: Mon, 5 Jan 2009 02:08:30 -0800
Message-ID: <200901050208.30918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by alsa0.perex.cz (Postfix) with SMTP id E53A01037FF
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 11:08:34 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
List-Id: alsa-devel@alsa-project.org

From: David Brownell <dbrownell@users.sourceforge.net>

DaVinci ASoC: fix multiboard buglet

Minor bugfix:  now that DaVinci kernels can support multiple
boards, board-specific ASoC components need to verify they're
running on the right board before initializing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
>From the DaVinci tree ... didn't realize davinci-sffsdr.c
was already queued for mainline.

 sound/soc/davinci/davinci-sffsdr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -24,6 +24,7 @@
 #include <sound/soc-dapm.h>
 
 #include <asm/dma.h>
+#include <asm/mach-types.h>
 #include <asm/plat-sffsdr/sffsdr-fpga.h>
 
 #include <mach/mcbsp.h>
@@ -115,6 +116,9 @@ static int __init sffsdr_init(void)
 {
 	int ret;
 
+	if (!machine_is_sffsdr())
+		return -EINVAL;
+
 	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
 	if (!sffsdr_snd_device) {
 		printk(KERN_ERR "platform device allocation failed\n");
