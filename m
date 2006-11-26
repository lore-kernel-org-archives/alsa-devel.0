From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] Bit clock matching error
Date: Sun, 26 Nov 2006 15:44:49 +0000
Message-ID: <1164555889.7941.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pbqlznt+aLRE5mJsjLm8"
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
Cc: pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--=-pbqlznt+aLRE5mJsjLm8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Philipp Zabel fixes a bug whereby the BCLK matching fails
when the Codec BCLK is constant and the CPU BCLK is based upon a
divider.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-pbqlznt+aLRE5mJsjLm8
Content-Disposition: attachment; filename=bclk.patch
Content-Type: text/x-patch; name=bclk.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 840a08bfad3d soc/soc-core.c
--- a/soc/soc-core.c	Sat Nov 25 22:02:47 2006 +0000
+++ b/soc/soc-core.c	Sun Nov 26 07:18:41 2006 +0000
@@ -424,7 +424,7 @@ static int soc_hw_match_params(struct sn
 				/* normalise cpu bfs div & codec const mult */
 				codec_bfs = soc_bfs_rate_to_div(codec_dai_mode->bfs, rate,
 					mclk, rtd->codec_dai->dai_runtime.pcmfmt, chn);
-				if(codec_dai_mode->bfs & codec_bfs) {
+				if(cpu_dai_mode->bfs & codec_bfs) {
 					rtd->cpu_dai->dai_runtime.bfs = codec_bfs;
 					rtd->codec_dai->dai_runtime.bfs = codec_dai_mode->bfs;
 				} else

--=-pbqlznt+aLRE5mJsjLm8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-pbqlznt+aLRE5mJsjLm8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-pbqlznt+aLRE5mJsjLm8--
