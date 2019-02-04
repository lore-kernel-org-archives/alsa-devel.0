From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: x86: Avoid passing NULL to memory
	allocators
Date: Mon,  4 Feb 2019 14:42:18 +0100
Message-ID: <20190204134222.9560-2-tiwai@suse.de>
References: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BE7B2674C0
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 14:42:26 +0100 (CET)
In-Reply-To: <20190204134222.9560-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

We should pass a proper	non-NULL device	object to memory allocators
although it was accepted in the past.  The card->dev points to the
most appropriate device object in such a case, so let's put it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 16ca91f57e7f..80f79ecffc71 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1812,7 +1812,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		 * try to allocate 600k buffer as default which is large enough
 		 */
 		snd_pcm_lib_preallocate_pages_for_all(pcm,
-						      SNDRV_DMA_TYPE_DEV_UC, NULL,
+						      SNDRV_DMA_TYPE_DEV_UC,
+						      card->dev,
 						      HAD_DEFAULT_BUFFER, HAD_MAX_BUFFER);
 
 		/* create controls */
-- 
2.16.4
