From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/4] ALSA: atiixp: constify ac97_pcm structures
Date: Wed, 23 Aug 2017 17:39:27 +0530
Message-ID: <1503490168-26501-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/pci/atiixp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a40c918..fa70804 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1183,7 +1183,7 @@ static int snd_atiixp_spdif_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_atiixp_pcm_pointer,
 };
 
-static struct ac97_pcm atiixp_pcm_defs[] = {
+static const struct ac97_pcm atiixp_pcm_defs[] = {
 	/* front PCM */
 	{
 		.exclusive = 1,
-- 
1.9.1
