From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [08/29] ALSA: dice: clear device lock when closing hwdep
	device
Date: Mon, 21 Oct 2013 21:25:21 +0200
Message-ID: <52657FA1.9010303@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ensure that misbehaving or aborted userspace programs do not
accidentally keep the lock.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 7225878..ef04089 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -966,6 +966,18 @@ static int dice_hwdep_unlock(struct dice *dice)
 	return err;
 }

+static int dice_hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct dice *dice = hwdep->private_data;
+
+	spin_lock_irq(&dice->lock);
+	if (dice->dev_lock_count == -1)
+		dice->dev_lock_count = 0;
+	spin_unlock_irq(&dice->lock);
+
+	return 0;
+}
+
 static int dice_hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
 			    unsigned int cmd, unsigned long arg)
 {
@@ -998,6 +1010,7 @@ static int dice_create_hwdep(struct dice *dice)
 {
 	static const struct snd_hwdep_ops ops = {
 		.read         = dice_hwdep_read,
+		.release      = dice_hwdep_release,
 		.poll         = dice_hwdep_poll,
 		.ioctl        = dice_hwdep_ioctl,
 		.ioctl_compat = dice_hwdep_compat_ioctl,

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
