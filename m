From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 24/26] [media] solo6x10: Convert to
	copy_silence ops
Date: Thu, 11 May 2017 23:09:23 +0200
Message-ID: <20170511210925.18208-25-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02578266FFE
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:33 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BD655AEEC
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

Replace the copy and the silence ops with the new merged ops.
It's a capture stream, thus no silence is needed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/solo6x10/solo6x10-g723.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
index 36e93540bb49..9bc4142481d8 100644
--- a/drivers/media/pci/solo6x10/solo6x10-g723.c
+++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
@@ -225,7 +225,7 @@ static snd_pcm_uframes_t snd_solo_pcm_pointer(struct snd_pcm_substream *ss)
 
 static int snd_solo_pcm_copy(struct snd_pcm_substream *ss, int channel,
 			     snd_pcm_uframes_t pos, void __user *dst,
-			     snd_pcm_uframes_t count)
+			     snd_pcm_uframes_t count, bool in_kernel)
 {
 	struct solo_snd_pcm *solo_pcm = snd_pcm_substream_chip(ss);
 	struct solo_dev *solo_dev = solo_pcm->solo_dev;
@@ -242,10 +242,11 @@ static int snd_solo_pcm_copy(struct snd_pcm_substream *ss, int channel,
 		if (err)
 			return err;
 
-		err = copy_to_user(dst + (i * G723_PERIOD_BYTES),
+		if (in_kernel)
+			memcpy((void *)dst + (i * G723_PERIOD_BYTES),
+			       solo_pcm->g723_buf, G723_PERIOD_BYTES);
+		else if (copy_to_user(dst + (i * G723_PERIOD_BYTES),
 				   solo_pcm->g723_buf, G723_PERIOD_BYTES);
-
-		if (err)
 			return -EFAULT;
 	}
 
@@ -261,7 +262,7 @@ static const struct snd_pcm_ops snd_solo_pcm_ops = {
 	.prepare = snd_solo_pcm_prepare,
 	.trigger = snd_solo_pcm_trigger,
 	.pointer = snd_solo_pcm_pointer,
-	.copy = snd_solo_pcm_copy,
+	.copy_silence = snd_solo_pcm_copy,
 };
 
 static int snd_solo_capture_volume_info(struct snd_kcontrol *kcontrol,
-- 
2.12.2
