From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: intel_hdmi: Use strlcpy() instead of
	strncpy()
Date: Wed, 27 Jun 2018 15:01:38 +0200
Message-ID: <20180627130138.12026-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 84D3A267973
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 15:01:40 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DC250AFB2
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:01:39 +0000 (UTC)
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

hdmi_lpe_audio_probe() copies the pcm name string via strncpy(), but
as a gcc8 warning suggests, it misses a NUL terminator, and unlikely
the expected result.

Use the proper one, strlcpy() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 4ed9d0c41843..edc9f5a34eff 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1854,7 +1854,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strncpy(pcm->name, card->shortname, strlen(card->shortname));
+		strlcpy(pcm->name, card->shortname, strlen(card->shortname));
 		/* setup the ops for playabck */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
-- 
2.17.1
