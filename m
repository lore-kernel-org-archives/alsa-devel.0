From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC codec probe failure bug
Date: Mon, 29 Jan 2007 22:13:04 +0000
Message-ID: <1170108784.31420.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UP8DfcYtIQIFzcny2IqO"
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


--=-UP8DfcYtIQIFzcny2IqO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug whereby some resources were not being freed when
codec probe() failed.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-UP8DfcYtIQIFzcny2IqO
Content-Disposition: attachment; filename=asoc-probe-bug.patch
Content-Type: text/x-patch; name=asoc-probe-bug.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d7d86515fc27 soc/soc-core.c
--- a/soc/soc-core.c	Mon Jan 29 15:33:49 2007 +0100
+++ b/soc/soc-core.c	Mon Jan 29 21:33:01 2007 +0000
@@ -1234,7 +1234,7 @@ platform_err:
 		codec_dev->remove(pdev);
 
 cpu_dai_err:
-	for (i--; i > 0; i--) {
+	for (i--; i >= 0; i--) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
 			cpu_dai->remove(pdev);

--=-UP8DfcYtIQIFzcny2IqO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-UP8DfcYtIQIFzcny2IqO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-UP8DfcYtIQIFzcny2IqO--
