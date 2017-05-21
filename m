From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] staging: bcm2835-audio: Deliver
	indirect-PCM transfer error
Date: Sun, 21 May 2017 21:02:57 +0200
Message-ID: <20170521190258.1178-7-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9CA9266C8B
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 21:03:07 +0200 (CEST)
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e8cf0b97bf02..3637ddf909a4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -353,9 +353,8 @@ static int snd_bcm2835_pcm_ack(struct snd_pcm_substream *substream)
 	struct snd_pcm_indirect *pcm_indirect = &alsa_stream->pcm_indirect;
 
 	pcm_indirect->hw_queue_size = runtime->hw.buffer_bytes_max;
-	snd_pcm_indirect_playback_transfer(substream, pcm_indirect,
-					   snd_bcm2835_pcm_transfer);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream, pcm_indirect,
+						  snd_bcm2835_pcm_transfer);
 }
 
 /* trigger callback */
-- 
2.13.0
