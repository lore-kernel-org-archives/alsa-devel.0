From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] ad1848: fix AD1848P macro
Date: Sun, 09 Sep 2007 19:35:27 +0200
Message-ID: <46E42EDF.3090508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040403070400030304010904"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B234103915
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 19:42:14 +0200 (CEST)
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040403070400030304010904
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Consistent variable naming is a good thing, but let's be a little less 
sneaky about enforcing it... ;-/

Rene.

--------------040403070400030304010904
Content-Type: text/plain;
 name="ad1848_eeks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ad1848_eeks.diff"

diff --git a/include/sound/ad1848.h b/include/sound/ad1848.h
index b2c3f00..ca0b6c3 100644
--- a/include/sound/ad1848.h
+++ b/include/sound/ad1848.h
@@ -27,7 +27,7 @@
 
 /* IO ports */
 
-#define AD1848P( codec, x ) ( (chip) -> port + c_d_c_AD1848##x )
+#define AD1848P( chip, x ) ( (chip) -> port + c_d_c_AD1848##x )
 
 #define c_d_c_AD1848REGSEL	0
 #define c_d_c_AD1848REG		1

--------------040403070400030304010904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040403070400030304010904--
