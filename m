From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [27/29] ALSA: dice: dice_proc_read: remove wrong typecast
Date: Mon, 21 Oct 2013 21:40:49 +0200
Message-ID: <52658341.2000706@ladisch.de>
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

Remove a wrong typecast that resulted from a copy-and-paste error.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 25a9636..5f0f102 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1053,8 +1053,7 @@ static void dice_proc_read(struct snd_info_entry *entry,
 			break;
 		snd_iprintf(buffer, "rx %u:\n", stream);
 		snd_iprintf(buffer, "  iso channel: %d\n", (int)buf.rx.iso);
-		snd_iprintf(buffer, "  sequence start: %u\n",
-			    (int)buf.rx.seq_start);
+		snd_iprintf(buffer, "  sequence start: %u\n", buf.rx.seq_start);
 		snd_iprintf(buffer, "  audio channels: %u\n",
 			    buf.rx.number_audio);
 		snd_iprintf(buffer, "  midi ports: %u\n", buf.rx.number_midi);

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
