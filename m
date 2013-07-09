From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] firewire-speakers: remove not-reused member
	from structure
Date: Wed, 10 Jul 2013 00:22:46 +0900
Message-ID: <1373383366-14340-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A8522625D8
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 17:25:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"pcm" member in struct fwspk is used to set pcm operations but is not used
again. This commit remove this member and set pcm operations with
snd_pcm_set_ops().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 2c63865..fe9e6e2 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -49,7 +49,6 @@ struct fwspk {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	const struct device_info *device_info;
-	struct snd_pcm_substream *pcm;
 	struct mutex mutex;
 	struct cmp_connection connection;
 	struct amdtp_out_stream stream;
@@ -363,8 +362,7 @@ static int fwspk_create_pcm(struct fwspk *fwspk)
 		return err;
 	pcm->private_data = fwspk;
 	strcpy(pcm->name, fwspk->device_info->short_name);
-	fwspk->pcm = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-	fwspk->pcm->ops = &ops;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
 	return 0;
 }
 
-- 
1.7.10.4
