From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] Fix WM9712 register cache entry
Date: Wed, 14 Feb 2007 13:28:48 +0000
Message-ID: <1171459728.13765.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/8Ep27RkzjG+d6mvj38/"
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
Cc: Joe Sauer <jsauer@vernier.com>
List-Id: alsa-devel@alsa-project.org


--=-/8Ep27RkzjG+d6mvj38/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Joe Sauer fixes the WM9712 codec register cache value for
register 0x08. Value should be 0x0f0f and not 0xf0f0.

Signed-off-by: Joe Sauer <jsauer@vernier.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>



--=-/8Ep27RkzjG+d6mvj38/
Content-Disposition: attachment; filename=asoc-wm9712-reg.patch
Content-Type: text/x-patch; name=asoc-wm9712-reg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r ee0908962557 soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Wed Feb 14 13:26:17 2007 +0100
+++ b/soc/codecs/wm9712.c	Wed Feb 14 13:23:20 2007 +0000
@@ -39,7 +39,7 @@ static int ac97_write(struct snd_soc_cod
  */
 static const u16 wm9712_reg[] = {
 	0x6174, 0x8000, 0x8000, 0x8000, // 6
-	0xf0f0, 0xaaa0, 0xc008, 0x6808, // e
+	0x0f0f, 0xaaa0, 0xc008, 0x6808, // e
 	0xe808, 0xaaa0, 0xad00, 0x8000, // 16
 	0xe808, 0x3000, 0x8000, 0x0000, // 1e
 	0x0000, 0x0000, 0x0000, 0x000f, // 26

--=-/8Ep27RkzjG+d6mvj38/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-/8Ep27RkzjG+d6mvj38/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-/8Ep27RkzjG+d6mvj38/--
