From: Peter Huewe <PeterHuewe@gmx.de>
Subject: [PATCH] sound/arm: Fix build failure caused by missing struct aaci definition
Date: Sat, 26 Dec 2009 03:27:45 +0100
Message-ID: <200912260327.46099.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757558AbZLZC1w@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterhuewe@gmx.de
List-Id: alsa-devel@alsa-project.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch fixes a build failure introduced by the patch
  ALSA: AACI: factor common hw_params logic into aaci_pcm_hw_params [1]
by adding/moving the aaci struct to the right position.

The patch mentioned above merged common source parts into one function,
but unfortunately left out the aaci struct and consequently caused a
build failure e.g. for arm versatile_config [2]

References:
[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d3aee7996c30f928bbbbfd0994148e35d2e83084
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/1893605/

Patch against Linus' tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 sound/arm/aaci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index c569986..656e474 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -441,6 +441,7 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
 	int err;
+	struct aaci *aaci = substream->private_data;
 
 	aaci_pcm_hw_free(substream);
 	if (aacirun->pcm_open) {
@@ -560,7 +561,6 @@ static int aaci_pcm_open(struct snd_pcm_substream *substream)
 static int aaci_pcm_playback_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
-	struct aaci *aaci = substream->private_data;
 	struct aaci_runtime *aacirun = substream->runtime->private_data;
 	unsigned int channels = params_channels(params);
 	int ret;
@@ -659,7 +659,6 @@ static struct snd_pcm_ops aaci_playback_ops = {
 static int aaci_pcm_capture_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
-	struct aaci *aaci = substream->private_data;
 	struct aaci_runtime *aacirun = substream->runtime->private_data;
 	int ret;
 
-- 
1.6.4.4
