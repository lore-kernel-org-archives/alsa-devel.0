From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: ice1712: fix boundary check in
	snd_wm8766_write()
Date: Thu, 7 Feb 2013 11:28:48 +0300
Message-ID: <20130207082848.GB18610@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id CC77B26171C
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 09:29:01 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Ondrej Zary <linux@rainbow-software.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The wm->regs[] array has WM8766_REG_COUNT (16) elements not
WM8766_REG_RESET (31).

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is a static checker thing, I can't test it.

diff --git a/sound/pci/ice1712/wm8766.c b/sound/pci/ice1712/wm8766.c
index 8072ade..e473f8a 100644
--- a/sound/pci/ice1712/wm8766.c
+++ b/sound/pci/ice1712/wm8766.c
@@ -31,7 +31,7 @@
 
 static void snd_wm8766_write(struct snd_wm8766 *wm, u16 addr, u16 data)
 {
-	if (addr < WM8766_REG_RESET)
+	if (addr < WM8766_REG_COUNT)
 		wm->regs[addr] = data;
 	wm->ops.write(wm, addr, data);
 }
