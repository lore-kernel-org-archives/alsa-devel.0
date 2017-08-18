From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/13] ALSA: ppc: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:17 +0530
Message-ID: <1503042321-26758-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/ppc/pmac.c    | 4 ++--
 sound/ppc/snd_ps3.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index a5843fc..ef2ab19 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -681,7 +681,7 @@ static int snd_pmac_capture_close(struct snd_pcm_substream *subs)
 /*
  */
 
-static struct snd_pcm_ops snd_pmac_playback_ops = {
+static const struct snd_pcm_ops snd_pmac_playback_ops = {
 	.open =		snd_pmac_playback_open,
 	.close =	snd_pmac_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -692,7 +692,7 @@ static int snd_pmac_capture_close(struct snd_pcm_substream *subs)
 	.pointer =	snd_pmac_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_pmac_capture_ops = {
+static const struct snd_pcm_ops snd_pmac_capture_ops = {
 	.open =		snd_pmac_capture_open,
 	.close =	snd_pmac_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index cdd44ab..36f34f4 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -772,7 +772,7 @@ static int snd_ps3_spdif_default_put(struct snd_kcontrol *kcontrol,
 	},
 };
 
-static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
+static const struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 	.open = snd_ps3_pcm_open,
 	.close = snd_ps3_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
