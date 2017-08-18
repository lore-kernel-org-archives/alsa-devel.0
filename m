From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/13] ALSA: arm: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:10 +0530
Message-ID: <1503042321-26758-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/arm/aaci.c       | 4 ++--
 sound/arm/pxa2xx-pcm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..e93b327 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -635,7 +635,7 @@ static int aaci_pcm_playback_trigger(struct snd_pcm_substream *substream, int cm
 	return ret;
 }
 
-static struct snd_pcm_ops aaci_playback_ops = {
+static const struct snd_pcm_ops aaci_playback_ops = {
 	.open		= aaci_pcm_open,
 	.close		= aaci_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -738,7 +738,7 @@ static int aaci_pcm_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops aaci_capture_ops = {
+static const struct snd_pcm_ops aaci_capture_ops = {
 	.open		= aaci_pcm_open,
 	.close		= aaci_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 83fcfac..1c6f4b4 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -68,7 +68,7 @@ static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 	return __pxa2xx_pcm_close(substream);
 }
 
-static struct snd_pcm_ops pxa2xx_pcm_ops = {
+static const struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= pxa2xx_pcm_open,
 	.close		= pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
