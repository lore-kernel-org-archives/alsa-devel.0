From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/4] ALSA: intel8x0: constify ac97_pcm structures
Date: Wed, 23 Aug 2017 17:39:28 +0530
Message-ID: <1503490168-26501-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503490168-26501-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503490168-26501-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ac97_pcm are not supposed to change at runtime. All functions
working with ac97_pcm provided by <sound/ac97_codec.h> work with
const ac97_pcm. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/intel8x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index fcd032e..10ede39 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1721,7 +1721,7 @@ static void snd_intel8x0_mixer_free_ac97(struct snd_ac97 *ac97)
 	chip->ac97[ac97->num] = NULL;
 }
 
-static struct ac97_pcm ac97_pcm_defs[] = {
+static const struct ac97_pcm ac97_pcm_defs[] = {
 	/* front PCM */
 	{
 		.exclusive = 1,
-- 
1.9.1
