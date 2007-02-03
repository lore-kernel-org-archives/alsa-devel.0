From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] snd-ak4114: Fix two array overflows
Date: Sat, 3 Feb 2007 18:53:31 +0100
Message-ID: <20070203185331.7c6c378b.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from kraid.nerim.net (smtp-106-saturday.nerim.net [62.4.16.106])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AAE8319
	for <alsa-devel@alsa-project.org>; Sat,  3 Feb 2007 18:53:26 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the handling of the TXCSB registers cache. There was one array
overflow in reg_write() and one in snd_ak4114_reg_write(). Thanks
to David Binderman for reporting the latter.

The second overflow probably doesn't matter much, given that the
function snd_ak4114_reg_write() appears to be never called. I wonder
why it exists and why it is exported.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
I do not have this device, can anyone please test this change?

 sound/i2c/other/ak4114.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.20-rc7.orig/sound/i2c/other/ak4114.c	2006-12-15 09:05:47.000000000 +0100
+++ linux-2.6.20-rc7/sound/i2c/other/ak4114.c	2007-02-02 20:48:49.000000000 +0100
@@ -42,8 +42,8 @@ static void reg_write(struct ak4114 *ak4
 	ak4114->write(ak4114->private_data, reg, val);
 	if (reg <= AK4114_REG_INT1_MASK)
 		ak4114->regmap[reg] = val;
-	else if (reg >= AK4114_REG_RXCSB0 && reg <= AK4114_REG_TXCSB4)
-		ak4114->txcsb[reg-AK4114_REG_RXCSB0] = val;
+	else if (reg >= AK4114_REG_TXCSB0 && reg <= AK4114_REG_TXCSB4)
+		ak4114->txcsb[reg-AK4114_REG_TXCSB0] = val;
 }
 
 static inline unsigned char reg_read(struct ak4114 *ak4114, unsigned char reg)
@@ -134,7 +134,8 @@ void snd_ak4114_reg_write(struct ak4114 
 	if (reg <= AK4114_REG_INT1_MASK)
 		reg_write(chip, reg, (chip->regmap[reg] & ~mask) | val);
 	else if (reg >= AK4114_REG_TXCSB0 && reg <= AK4114_REG_TXCSB4)
-		reg_write(chip, reg, (chip->txcsb[reg] & ~mask) | val);
+		reg_write(chip, reg,
+			  (chip->txcsb[reg-AK4114_REG_TXCSB0] & ~mask) | val);
 }
 
 void snd_ak4114_reinit(struct ak4114 *chip)


-- 
Jean Delvare

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
