From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 08/13] ALSA: pcmcia: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:16 +0530
Message-ID: <87abbbed3d1ccde13195745314468a504a2fc4ed.1503040251.git.arvind.yadav.cs@gmail.com>
References: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <19589e15b10f062109b5e90c9c253aefb2d3819c.1503040251.git.arvind.yadav.cs@gmail.com>
References: <19589e15b10f062109b5e90c9c253aefb2d3819c.1503040251.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
index b48aa0a..a81ec25 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
@@ -266,7 +266,7 @@ static snd_pcm_uframes_t pdacf_pcm_capture_pointer(struct snd_pcm_substream *sub
 /*
  * operators for PCM capture
  */
-static struct snd_pcm_ops pdacf_pcm_capture_ops = {
+static const struct snd_pcm_ops pdacf_pcm_capture_ops = {
 	.open =		pdacf_pcm_capture_open,
 	.close =	pdacf_pcm_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
