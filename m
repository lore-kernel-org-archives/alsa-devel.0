From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [15/29] ALSA: dice: avoid superflous write at bus reset
Date: Mon, 21 Oct 2013 21:29:20 +0200
Message-ID: <52658090.7080604@ladisch.de>
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

When a bus reset happens, the enable register is automatically cleared,
so we do not need to clear it manually when stopping the stream.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 59d5ca4..cfa98a8 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -246,6 +246,9 @@ static void dice_enable_clear(struct dice *dice)
 {
 	__be32 value;

+	if (!dice->global_enabled)
+		return;
+
 	value = 0;
 	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   global_address(dice, GLOBAL_ENABLE),
@@ -1009,6 +1012,8 @@ static void dice_bus_reset(struct fw_unit *unit)
 	 * manner.
 	 */
 	amdtp_out_stream_pcm_abort(&dice->stream);
+
+	dice->global_enabled = false;
 	dice_stream_stop_packets(dice);

 	dice_owner_update(dice);

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
