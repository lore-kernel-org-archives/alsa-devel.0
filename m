From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Typo in soc/atmel/sam9g20_wm8731.c
Date: Sat, 08 Aug 2009 13:02:16 -0400
Message-ID: <4A7DAF98.2040906@fosstel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070005010805080203040506"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE852465C
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 19:02:28 +0200 (CEST)
Received: from [207.35.173.122] (helo=[192.168.215.229])
	by a2s40.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <psanchez@fosstel.com>)
	id 1MZpJL-0008UT-FC
	for alsa-devel@alsa-project.org; Sat, 08 Aug 2009 13:02:27 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070005010805080203040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a patch to fix what I believe is a typo in this file.

---
  sound/soc/atmel/sam9g20_wm8731.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c 
b/sound/soc/atmel/sam9g20_wm8731.c
index 173a239..baa42f3 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -341,7 +341,7 @@ static int __init at91sam9g20ek_init(void)
  	}

  	pllb = clk_get(NULL, "pllb");
-	if (IS_ERR(mclk)) {
+	if (IS_ERR(pllb)) {
  		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
  		ret = PTR_ERR(mclk);
  		goto err_mclk;

--------------070005010805080203040506
Content-Type: text/x-vcard; charset=utf-8;
 name="psanchez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="psanchez.vcf"

begin:vcard
fn:Pedro I. Sanchez
n:Sanchez;Pedro I.
email;internet:psanchez@fosstel.com
tel;work:+1 613 216 7513
tel;cell:+1 613 818 2465
x-mozilla-html:FALSE
url:http://fosstel.com
version:2.1
end:vcard


--------------070005010805080203040506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070005010805080203040506--
