From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/2] ALSA: AACI: fix AC97 multiple-open bug
Date: Sun, 29 Nov 2009 16:39:52 +0000
Message-ID: <E1NEmoS-0001dM-3b@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D3EEF243BC
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 17:40:04 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index a03fe80..1456fc7 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -501,6 +501,10 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	aaci_pcm_hw_free(substream);
+	if (aacirun->pcm_open) {
+		snd_ac97_pcm_close(aacirun->pcm);
+		aacirun->pcm_open = 0;
+	}
 
 	err = devdma_hw_alloc(NULL, substream,
 			      params_buffer_bytes(params));
-- 
1.6.2.5
