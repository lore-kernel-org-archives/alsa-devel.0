From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] ASoC debug output build breakage
Date: Fri, 13 Oct 2006 16:46:52 +0100
Message-ID: <1160754412.3728.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-a7fkGXDDE8SmkICkoEo/"
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


--=-a7fkGXDDE8SmkICkoEo/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a build failure when ASoC debug is enabled.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>



--=-a7fkGXDDE8SmkICkoEo/
Content-Disposition: attachment; filename=asoc-debug.patch
Content-Type: text/x-patch; name=asoc-debug.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9fe5ddfba4ee soc/soc-core.c
--- a/soc/soc-core.c	Fri Oct 13 12:46:10 2006 +0200
+++ b/soc/soc-core.c	Fri Oct 13 16:43:29 2006 +0100
@@ -575,10 +575,11 @@ static int soc_pcm_open(struct snd_pcm_s
 	}
 
 	dbg("asoc: %s <-> %s info:\n", rtd->codec_dai->name, rtd->cpu_dai->name);
-	dbg("asoc: rate mask 0x%x \nasoc: min ch %d max ch %d\n"
-		"asoc: min rate %d max rate %d\n",
-		runtime->hw.rates, runtime->hw.channels_min,
-		runtime->hw.channels_max, runtime->hw.rate_min, runtime->hw.rate_max);
+	dbg("asoc: rate mask 0x%x\n", runtime->hw.rates);
+	dbg("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
+		runtime->hw.channels_max);
+	dbg("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
+		runtime->hw.rate_max);
 
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)

--=-a7fkGXDDE8SmkICkoEo/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-a7fkGXDDE8SmkICkoEo/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-a7fkGXDDE8SmkICkoEo/--
