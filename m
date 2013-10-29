From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: ali5451: Drop unused variable
Date: Tue, 29 Oct 2013 17:00:29 +0100
Message-ID: <1383062433-9388-7-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D7C31261178
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9FC99A5FE3
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The variable runtime is never used, and this might be even a source of
NULL-dereference.  Nothing better than killing it.

Spotted by coverity CID 100862.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ali5451/ali5451.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 3dfa12b670eb..c6835a3d64fb 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -855,7 +855,6 @@ static void snd_ali_disable_spdif_out(struct snd_ali *codec)
 static void snd_ali_update_ptr(struct snd_ali *codec, int channel)
 {
 	struct snd_ali_voice *pvoice;
-	struct snd_pcm_runtime *runtime;
 	struct snd_ali_channel_control *pchregs;
 	unsigned int old, mask;
 #ifdef ALI_DEBUG
@@ -872,7 +871,6 @@ static void snd_ali_update_ptr(struct snd_ali *codec, int channel)
 		return;
 
 	pvoice = &codec->synth.voices[channel];
-	runtime = pvoice->substream->runtime;
 
 	udelay(100);
 	spin_lock(&codec->reg_lock);
-- 
1.8.4.1
