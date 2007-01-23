From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] echo3g_dsp.c shouldn't include #include
	<linux/irq.h>
Date: Tue, 23 Jan 2007 16:17:56 +0100
Message-ID: <20070123151756.GH9093@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id F1A42323
	for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2007 16:17:48 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giuliano Pochini <pochini@shiny.it>, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Despite being under linux/, linux/irq.h shouldn't be #include'd by arch 
independent code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc4-mm1/sound/pci/echoaudio/echo3g_dsp.c.old	2007-01-23 15:16:37.000000000 +0100
+++ linux-2.6.20-rc4-mm1/sound/pci/echoaudio/echo3g_dsp.c	2007-01-23 14:22:49.000000000 +0100
@@ -39,7 +39,7 @@
 static int write_control_reg(struct echoaudio *chip, u32 ctl, u32 frq,
 			     char force);
 
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 {



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
