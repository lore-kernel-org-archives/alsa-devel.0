From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC WM8731 support for 32k @ 12MHz sysclk
Date: Tue, 30 Jan 2007 18:30:26 +0000
Message-ID: <1170181826.22167.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-semuaWLMkCaPILD4Lg9+"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-semuaWLMkCaPILD4Lg9+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for 32k audio on the WM8731 when running from a
12MHz system clock.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>


--=-semuaWLMkCaPILD4Lg9+
Content-Disposition: attachment; filename=asoc-wm8731-32k.patch
Content-Type: text/x-patch; name=asoc-wm8731-32k.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 3be2f03501ef soc/codecs/wm8731.c
--- a/soc/codecs/wm8731.c	Tue Jan 30 17:30:55 2007 +0100
+++ b/soc/codecs/wm8731.c	Tue Jan 30 18:29:20 2007 +0000
@@ -435,6 +435,7 @@ static const struct _coeff_div coeff_div
 	/* 32k */
 	{12288000, 32000, 384, 0x6, 0x0, 0x0},
 	{18432000, 32000, 576, 0x6, 0x1, 0x0},
+	{12000000, 32000, 375, 0x6, 0x0, 0x1},
 
 	/* 8k */
 	{12288000, 8000, 1536, 0x3, 0x0, 0x0},

--=-semuaWLMkCaPILD4Lg9+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-semuaWLMkCaPILD4Lg9+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-semuaWLMkCaPILD4Lg9+--
