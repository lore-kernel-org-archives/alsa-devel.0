From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 12/13] ALSA: spi: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:20 +0530
Message-ID: <1503042321-26758-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/spi/at73c213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index fac7e6e..1ef52ed 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -322,7 +322,7 @@ static int snd_at73c213_pcm_trigger(struct snd_pcm_substream *substream,
 	return pos;
 }
 
-static struct snd_pcm_ops at73c213_playback_ops = {
+static const struct snd_pcm_ops at73c213_playback_ops = {
 	.open		= snd_at73c213_pcm_open,
 	.close		= snd_at73c213_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
