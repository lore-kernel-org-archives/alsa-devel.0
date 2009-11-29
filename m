From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/2] ALSA: AACI: fix recording bug
Date: Sun, 29 Nov 2009 16:39:59 +0000
Message-ID: <E1NEmoZ-0001dQ-St@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 75A39243C2
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 17:40:10 +0100 (CET)
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

pcm->r[1].slots is the double rate slot information, not the
capture information.  For capture, 'pcm' will already be the
capture ac97 pcm structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 1456fc7..eb715e7 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -518,7 +518,7 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 	else
 		err = snd_ac97_pcm_open(aacirun->pcm, params_rate(params),
 					params_channels(params),
-					aacirun->pcm->r[1].slots);
+					aacirun->pcm->r[0].slots);
 
 	if (err)
 		goto out;
-- 
1.6.2.5
