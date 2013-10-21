From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [18/29] ALSA: dice: fix locking
Date: Mon, 21 Oct 2013 21:31:05 +0200
Message-ID: <526580F9.2010205@ladisch.de>
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

From: Stefan Richter <stefanr@s5r6.in-berlin.de>

Avoid a lock inversion between dice->mutex and pcm->open_mutex.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 2d198ae..2d3a04e 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -981,12 +981,12 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct dice *dice = dev_get_drvdata(&unit->device);

-	mutex_lock(&dice->mutex);
-
 	amdtp_out_stream_pcm_abort(&dice->stream);

 	snd_card_disconnect(dice->card);

+	mutex_lock(&dice->mutex);
+
 	dice_stream_stop(dice);
 	dice_owner_clear(dice);

@@ -999,8 +999,6 @@ static void dice_bus_reset(struct fw_unit *unit)
 {
 	struct dice *dice = dev_get_drvdata(&unit->device);

-	mutex_lock(&dice->mutex);
-
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
 	 * off contemplating its own navel for hundreds of milliseconds before
@@ -1011,6 +1009,8 @@ static void dice_bus_reset(struct fw_unit *unit)
 	 */
 	amdtp_out_stream_pcm_abort(&dice->stream);

+	mutex_lock(&dice->mutex);
+
 	dice->global_enabled = false;
 	dice_stream_stop_packets(dice);


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
