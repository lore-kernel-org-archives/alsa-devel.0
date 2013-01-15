From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/hdmi - Work around "alsactl restore"
	errors
Date: Tue, 15 Jan 2013 14:59:41 +0100
Message-ID: <1358258382-6515-2-git-send-email-tiwai@suse.de>
References: <1358258382-6515-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A6F926163E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 14:59:44 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 68BD6A51FD
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 14:59:43 +0100 (CET)
In-Reply-To: <1358258382-6515-1-git-send-email-tiwai@suse.de>
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

When "alsactl restore" is performed on HDMI codecs, it tries to
restore the channel map value since the channel map controls are
writable.  But hdmi_chmap_ctl_put() returns -EBADFD when no PCM stream
is assigned yet, and this results in an error message from alsactl.
Although the error is harmless, it's certainly ugly and can be
regarded as a regression.

As a workaround, this patch changes the return code in such a case to
be zero for making others happy.  (A slight excuse is: when the chmap
is changed through the proper alsa-lib API, the PCM status is checked
there anyway, so we don't have to be too strict in the kernel side.)

Cc: <stable@vger.kernel.org> [v3.7+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b6c21ea..807a2aa 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1502,7 +1502,7 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	ctl_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	substream = snd_pcm_chmap_substream(info, ctl_idx);
 	if (!substream || !substream->runtime)
-		return -EBADFD;
+		return 0; /* just for avoiding error from alsactl restore */
 	switch (substream->runtime->status->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_SETUP:
-- 
1.8.1
