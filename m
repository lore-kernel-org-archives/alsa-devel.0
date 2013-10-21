From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [06/29] ALSA: dice: fix hang when unplugging a running device
Date: Mon, 21 Oct 2013 21:24:18 +0200
Message-ID: <52657F62.5070101@ladisch.de>
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

When aborting a PCM stream, the xrun is signaled only if the stream is
running.  When disconnecting a PCM stream, calling snd_card_disconnect()
too early would change the stream into a non-running state and thus
prevent the xrun from being noticed by user space.

To prevent this, move the snd_card_disconnect() call after the xrun.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 63446f8..d0575a9 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1000,12 +1000,15 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct dice *dice = dev_get_drvdata(&unit->device);

-	snd_card_disconnect(dice->card);
-
 	mutex_lock(&dice->mutex);
+
 	amdtp_out_stream_pcm_abort(&dice->stream);
+
+	snd_card_disconnect(dice->card);
+
 	dice_stream_stop(dice);
 	dice_owner_clear(dice);
+
 	mutex_unlock(&dice->mutex);

 	snd_card_free_when_closed(dice->card);

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
