From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sc6000: fix older card initialization
Date: Thu, 23 Apr 2009 21:46:19 +0200
Message-ID: <20090423214619.337e25b1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0550371267783788479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id EBD031037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:42:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============0550371267783788479==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The last patch to handle newer cards like SC7000
broke initialization of the SC6000. Fix this.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sc6000.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 983ab7e..c803b2e 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -391,7 +391,6 @@ static int __devinit sc6000_init_board(char __iomem *vport,
 	int config = mss_config |
 		     sc6000_mpu_irq_to_softcfg(mpu_irq[dev]);
 	int err;
-	int cfg[2];
 	int old = 0;
 
 	err = sc6000_dsp_reset(vport);
@@ -421,11 +420,18 @@ static int __devinit sc6000_init_board(char __iomem *vport,
 		answer, version[0], version[1]);
 
 	/* set configuration */
-	sc6000_hw_cfg_encode(vport, &cfg[0], port[dev], mpu_port[dev],
-			     mss_port[dev]);
-	if (sc6000_hw_cfg_write(vport, cfg) < 0) {
-		snd_printk(KERN_ERR "sc6000_hw_cfg_write: failed!\n");
-		return -EIO;
+	sc6000_write(vport, COMMAND_5C);
+	if (sc6000_read(vport) < 0)
+		old = 1;
+
+	if (!old) {
+		int cfg[2];
+		sc6000_hw_cfg_encode(vport, &cfg[0], port[dev], mpu_port[dev],
+				     mss_port[dev]);
+		if (sc6000_hw_cfg_write(vport, cfg) < 0) {
+			snd_printk(KERN_ERR "sc6000_hw_cfg_write: failed!\n");
+			return -EIO;
+		}
 	}
 	err = sc6000_setup_board(vport, config);
 	if (err < 0) {
@@ -434,10 +440,6 @@ static int __devinit sc6000_init_board(char __iomem *vport,
 	}
 
 	sc6000_dsp_reset(vport);
-	sc6000_write(vport, COMMAND_5C);
-	if (sc6000_read(vport) < 0)
-		old = 1;
-	sc6000_dsp_reset(vport);
 
 	if (!old) {
 		sc6000_write(vport, COMMAND_60);
-- 
1.6.0.3


----------------------------------------------------------------------
Dzwonki na komorkê!
Sprawdz >> http://link.interia.pl/f2127 


--===============0550371267783788479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0550371267783788479==--
