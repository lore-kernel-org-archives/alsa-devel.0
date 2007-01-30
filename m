From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: (no subject)
Date: Tue, 30 Jan 2007 20:51:47 +0100
Message-ID: <200701302051.47325.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

some oopses here running -rt kernels vanished after applying this.

      Karsten
------------------------------------------------------------------- 
snd_hwdep_release() racefix


snd_card_file_remove() can free the snd_card.
Touch hw->* only before calling snd_card_file_remove().

Unrelated: Allow hwdep devices not to have own ops.release();


Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- /alsa-kernel/core/hwdep.c_	2007-01-30 20:32:01.000000000 +0100
+++ /alsa-kernel/core/hwdep.c	2007-01-30 20:32:01.000000000 +0100
@@ -156,15 +156,16 @@
 	int err = -ENXIO;
 	struct snd_hwdep *hw = file->private_data;
 	struct module *mod = hw->card->module;
+
 	mutex_lock(&hw->open_mutex);
-	if (hw->ops.release) {
+	if (hw->ops.release)
 		err = hw->ops.release(hw, file);
-		wake_up(&hw->open_wait);
-	}
 	if (hw->used > 0)
 		hw->used--;
-	snd_card_file_remove(hw->card, file);
 	mutex_unlock(&hw->open_mutex);
+	wake_up(&hw->open_wait);
+
+	snd_card_file_remove(hw->card, file);
 	module_put(mod);
 	return err;
 }

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
