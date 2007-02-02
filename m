From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 18/19] ASoC 0.13 Sharp tosa machine
Date: Fri, 02 Feb 2007 14:46:23 +0000
Message-ID: <1170427583.18082.149.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yaM4Z2DoSdWXYHJHjOsh"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-yaM4Z2DoSdWXYHJHjOsh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the Sharp tosa machine driver to the new API in ASoC
0.13.

Changes:-

o  Update machine operations to new API.

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


--=-yaM4Z2DoSdWXYHJHjOsh
Content-Disposition: attachment; filename="asoc13-tosa.patch"
Content-Type: text/x-patch; name="asoc13-tosa.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/pxa/tosa.c
--- a/soc/pxa/tosa.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/tosa.c	Thu Feb 01 17:49:01 2007 +0000
@@ -40,6 +40,7 @@
 
 #include "../codecs/wm9712.h"
 #include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
 
 static struct snd_soc_machine tosa;
 
@@ -228,12 +229,14 @@ static struct snd_soc_dai_link tosa_dai[
 	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
 	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
 	.init = tosa_ac97_init,
+	.ops = &tosa_ops,
 },
 {
 	.name = "AC97 Aux",
 	.stream_name = "AC97 Aux",
 	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
 	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	.ops = &tosa_ops,
 },
 };
 
@@ -241,7 +244,6 @@ static struct snd_soc_machine tosa = {
 	.name = "Tosa",
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
-	.ops = &tosa_ops,
 };
 
 static struct snd_soc_device tosa_snd_devdata = {

--=-yaM4Z2DoSdWXYHJHjOsh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-yaM4Z2DoSdWXYHJHjOsh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-yaM4Z2DoSdWXYHJHjOsh--
