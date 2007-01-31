From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC force running of delayed PM
	work	at	suspend() and	remove()
Date: Wed, 31 Jan 2007 17:22:37 +0000
Message-ID: <1170264157.16760.89.camel@localhost.localdomain>
References: <1170246385.16760.51.camel@localhost.localdomain>
	<s5hzm7znxcz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iQJ8pAcA/zrAZbbdorgk"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzm7znxcz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-iQJ8pAcA/zrAZbbdorgk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-01-31 at 14:23 +0100, Takashi Iwai wrote:
> At Wed, 31 Jan 2007 12:26:25 +0000,
> Liam Girdwood wrote:
> > 
> > This patch fixes a bug whereby the power management delayed work would
> > never be run at driver suspend() or module remove(). Delayed work would
> > be created (after audio had finished) with a long delay (~5 secs) and
> > was sometimes never queued before flush_scheduled_work() was being
> > called at suspend or module remove. This caused the delayed work to
> > queued after the module had been removed or after resume.
> > 
> > This patch forces any delayed work to complete by cancelling it (timer
> > cannot fire and add it to queue later), scheduling it for now and
> > waiting on it's completion.
> > 
> > This is something I probably would like to add to workqueue.c in the
> > next merge window, however it's here atm because it can oops.
> > 
> > Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>  
> 
> Applied.  I guess we need to fix a similar (flush_delayed_work) in
> ac97 codec code, too.

Patch attached for AC97 codec.

Signed-off-by Liam Girdwood <lg@opensource.wolfsonmicro.com>

Liam

--=-iQJ8pAcA/zrAZbbdorgk
Content-Disposition: attachment; filename=ac97-delayed-work.patch
Content-Type: text/x-patch; name=ac97-delayed-work.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -r 2a5adb550155 pci/ac97/ac97_codec.c
--- a/pci/ac97/ac97_codec.c	Wed Jan 31 14:34:38 2007 +0100
+++ b/pci/ac97/ac97_codec.c	Wed Jan 31 17:19:22 2007 +0000
@@ -965,6 +965,22 @@ AD18XX_PCM_BITS("LFE Playback Volume", 2
  *
  */
 
+static int run_ac97_delayed_work(struct delayed_work *dwork)
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
+
 static void snd_ac97_powerdown(struct snd_ac97 *ac97);
 
 static int snd_ac97_bus_free(struct snd_ac97_bus *bus)
@@ -989,8 +1005,7 @@ static int snd_ac97_free(struct snd_ac97
 {
 	if (ac97) {
 #ifdef CONFIG_SND_AC97_POWER_SAVE
-		cancel_delayed_work(&ac97->power_work);
-		flush_scheduled_work();
+		run_ac97_delayed_work(&ac97->power_work);
 #endif
 		snd_ac97_proc_done(ac97);
 		if (ac97->bus)
@@ -2417,8 +2432,7 @@ void snd_ac97_suspend(struct snd_ac97 *a
 	if (ac97->build_ops->suspend)
 		ac97->build_ops->suspend(ac97);
 #ifdef CONFIG_SND_AC97_POWER_SAVE
-	cancel_delayed_work(&ac97->power_work);
-	flush_scheduled_work();
+	run_ac97_delayed_work(&ac97->power_work);
 #endif
 	snd_ac97_powerdown(ac97);
 }

--=-iQJ8pAcA/zrAZbbdorgk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-iQJ8pAcA/zrAZbbdorgk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-iQJ8pAcA/zrAZbbdorgk--
