From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC force running of delayed PM work at
	suspend() and	remove()
Date: Wed, 31 Jan 2007 12:26:25 +0000
Message-ID: <1170246385.16760.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-IC9PopZMU5OHYNxxqs8z"
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


--=-IC9PopZMU5OHYNxxqs8z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug whereby the power management delayed work would
never be run at driver suspend() or module remove(). Delayed work would
be created (after audio had finished) with a long delay (~5 secs) and
was sometimes never queued before flush_scheduled_work() was being
called at suspend or module remove. This caused the delayed work to
queued after the module had been removed or after resume.

This patch forces any delayed work to complete by cancelling it (timer
cannot fire and add it to queue later), scheduling it for now and
waiting on it's completion.

This is something I probably would like to add to workqueue.c in the
next merge window, however it's here atm because it can oops.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>  



--=-IC9PopZMU5OHYNxxqs8z
Content-Disposition: attachment; filename=asoc-delayed-work.patch
Content-Type: text/x-patch; name=asoc-delayed-work.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r b4265ee02e26 soc/soc-core.c
--- a/soc/soc-core.c	Wed Jan 31 10:35:19 2007 +0100
+++ b/soc/soc-core.c	Wed Jan 31 12:06:05 2007 +0000
@@ -76,6 +76,25 @@ static int pmdown_time = 5000;
 static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
+
+/*
+ * This function forces any delayed work to be queued and run.
+ */
+static int run_delayed_work(struct delayed_work *dwork)
+{
+	int ret;
+
+	/* cancel any work waiting to be queued. */
+	ret = cancel_delayed_work(dwork);
+
+	/* if there was any work waiting then we run it now and
+	 * wait for it's completion */
+	if (ret) {
+		schedule_delayed_work(dwork, 0);
+		flush_scheduled_work();
+	}
+	return ret;
+}
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
 /* unregister ac97 codec */
@@ -1101,7 +1120,7 @@ static int soc_suspend(struct platform_d
 	}
 
 	/* close any waiting streams and save state */
-	flush_scheduled_work();
+	run_delayed_work(&socdev->delayed_work);
 	codec->suspend_dapm_state = codec->dapm_state;
 
 	for(i = 0; i < codec->num_dai; i++) {
@@ -1254,6 +1273,8 @@ static int soc_remove(struct platform_de
 	struct snd_soc_machine *machine = socdev->machine;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
+
+	run_delayed_work(&socdev->delayed_work);
 
 	if (platform->remove)
 		platform->remove(pdev);

--=-IC9PopZMU5OHYNxxqs8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-IC9PopZMU5OHYNxxqs8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-IC9PopZMU5OHYNxxqs8z--
