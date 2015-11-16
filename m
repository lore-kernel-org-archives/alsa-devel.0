From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] sound/soc/davinci: fix error case in mcasp_set_ctl_reg
Date: Mon, 16 Nov 2015 18:40:26 +0100
Message-ID: <20151116174026.GA1735@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, peter.ujfalusi@ti.com, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


This fixes typo in comment and fixes mcasp_set_ctl_reg to actually
printk on error as author wanted, and cleans it up. Yes, i will end up
being 1001 in the old code.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b960e62..a739ca8 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -148,15 +150,14 @@ static void mcasp_set_ctl_reg(struct davinci_mcasp *mcasp, u32 ctl_reg, u32 val)
 
 	mcasp_set_bits(mcasp, ctl_reg, val);
 
-	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
+	/* programming GBLCTL needs to read back from GBLCTL and verify */
 	/* loop count is to avoid the lock-up */
-	for (i = 0; i < 1000; i++) {
+	for (i = 0; i <= 1000; i++) {
 		if ((mcasp_get_reg(mcasp, ctl_reg) & val) == val)
-			break;
+			return;
 	}
 
-	if (i == 1000 && ((mcasp_get_reg(mcasp, ctl_reg) & val) != val))
-		printk(KERN_ERR "GBLCTL write error\n");
+	printk(KERN_ERR "GBLCTL write error\n");
 }
 
 static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
