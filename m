From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] Remove trailing white space from wm9712.c
Date: Mon, 04 Dec 2006 14:23:23 +0000
Message-ID: <1165242203.17141.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SqtFtCJ155aWihLHfu5m"
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


--=-SqtFtCJ155aWihLHfu5m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch removes some trailing white space from the WM9712 ASoC codec
driver.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-SqtFtCJ155aWihLHfu5m
Content-Disposition: attachment; filename=wm9712-trailing-space.patch
Content-Type: text/x-patch; name=wm9712-trailing-space.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bc7ef767d0cf soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Wed Nov 29 15:29:40 2006 +0100
+++ b/soc/codecs/wm9712.c	Mon Dec 04 14:10:25 2006 +0000
@@ -45,7 +45,7 @@ static int ac97_write(struct snd_soc_cod
 /* may need to expand this */
 static struct snd_soc_dai_mode ac97_modes[] = {
 	{
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE,	
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE,
 		.pcmrate = AC97_RATES,
 		.pcmdir = AC97_DIR,
 	},

--=-SqtFtCJ155aWihLHfu5m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-SqtFtCJ155aWihLHfu5m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-SqtFtCJ155aWihLHfu5m--
