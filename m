From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: x86: Fix missing spinlock and mutex
	initializations
Date: Wed, 28 Feb 2018 08:52:53 +0100
Message-ID: <20180228075254.15649-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 11EDA2671D2
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 08:52:57 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1C960AC98
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 07:52:57 +0000 (UTC)
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

The commit change for supporting the multiple ports moved involved
some code shuffling, and there the initializations of spinlock and
mutex in snd_intelhad object were dropped mistakenly.

This patch adds the missing initializations again for each port.

Fixes: b4eb0d522fcb ("ALSA: x86: Split snd_intelhad into card and PCM specific structures")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 96115c401292..cec62f9b7085 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1835,6 +1835,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		ctx->port = single_port ? -1 : port;
 		ctx->pipe = -1;
 
+		spin_lock_init(&ctx->had_spinlock);
+		mutex_init(&ctx->mutex);
 		INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
 
 		ret = snd_pcm_new(card, INTEL_HAD, port, MAX_PB_STREAMS,
-- 
2.16.2
