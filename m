From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [17/29] ALSA: dice: remove superfluous field
Date: Mon, 21 Oct 2013 21:30:30 +0200
Message-ID: <526580D6.2050803@ladisch.de>
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

The pcm field was not actually used.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 57ceb13..2d198ae 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -43,7 +43,6 @@ struct dice {
 	bool global_enabled;
 	wait_queue_head_t hwdep_wait;
 	u32 notification_bits;
-	struct snd_pcm_substream *pcm;
 	struct fw_iso_resources resources;
 	struct amdtp_out_stream stream;
 };
@@ -564,8 +563,7 @@ static int dice_create_pcm(struct dice *dice)
 		return err;
 	pcm->private_data = dice;
 	strcpy(pcm->name, dice->card->shortname);
-	dice->pcm = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-	dice->pcm->ops = &ops;
+	pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->ops = &ops;

 	return 0;
 }

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
