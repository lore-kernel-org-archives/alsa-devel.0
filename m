From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: UDA134X: Fix mistaken mute/unmute
 code
Date: Mon, 17 Aug 2009 19:43:29 +0800
Message-ID: <1250509409.1932.41.camel@shinel>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg73.qq.com (smtpbg73.qq.com [119.147.10.232])
	by alsa0.perex.cz (Postfix) with SMTP id CB9102433E
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 13:44:01 +0200 (CEST)
In-Reply-To: <20090817103248.GA4464@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for your remainder.
Using -p1 regenerate the patch.


--- a/sound/soc/codecs/uda134x.c	2009-07-14 09:18:52.000000000 +0800
+++ b/sound/soc/codecs/uda134x.c	2009-08-17 13:46:57.000000000 +0800
@@ -163,7 +163,7 @@
 	else
 		mute_reg &= ~(1<<2);
 
-	uda134x_write(codec, UDA134X_DATA010, mute_reg & ~(1<<2));
+	uda134x_write(codec, UDA134X_DATA010, mute_reg);
 
 	return 0;
 }
