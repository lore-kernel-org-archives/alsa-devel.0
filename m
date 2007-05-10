From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH4/5] ASoC S3C24xx machine drivers - I2C ID for
	LM4857
Date: Thu, 10 May 2007 14:00:45 +0100
Message-ID: <1178802045.10518.72.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XVsQbBrzVSUhMCSMVdfN"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id 108D424391
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:01:05 +0200 (CEST)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T7f82b3ba8bac140805bcc@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Thu, 10 May 2007 14:01:03 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--=-XVsQbBrzVSUhMCSMVdfN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds I2C ID for the LM4857 audio amp and corrects the spacing
of the WM8731, WM8750 and WM8753 ID's.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-XVsQbBrzVSUhMCSMVdfN
Content-Disposition: attachment; filename="i2c-id.patch"
Content-Type: text/x-patch; name="i2c-id.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/kernel/include/linux/i2c-id.h	Mon May 07 09:29:32 2007 +0200
+++ b/kernel/include/linux/i2c-id.h	Tue May 08 10:16:09 2007 +0100
@@ -116,9 +116,10 @@
 #define I2C_DRIVERID_KS0127	86	/* Samsung ks0127 video decoder */
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
 #define I2C_DRIVERID_ISL1208	88	/* Intersil ISL1208 RTC		*/
-#define I2C_DRIVERID_WM8731		89	/* Wolfson WM8731 audio codec */
-#define I2C_DRIVERID_WM8750		90	/* Wolfson WM8750 audio codec */
-#define I2C_DRIVERID_WM8753		91	/* Wolfson WM8753 audio codec */
+#define I2C_DRIVERID_WM8731	89	/* Wolfson WM8731 audio codec */
+#define I2C_DRIVERID_WM8750	90	/* Wolfson WM8750 audio codec */
+#define I2C_DRIVERID_WM8753	91	/* Wolfson WM8753 audio codec */
+#define I2C_DRIVERID_LM4857 	92 	/* LM4857 Audio Amplifier */
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */

--=-XVsQbBrzVSUhMCSMVdfN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-XVsQbBrzVSUhMCSMVdfN--
