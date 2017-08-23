From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/4] ALSA: aaci: constify ac97_pcm structures
Date: Wed, 23 Aug 2017 17:39:25 +0530
Message-ID: <1503490168-26501-2-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/arm/aaci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index e93b327..7780d32 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -786,7 +786,7 @@ static int aaci_resume(struct device *dev)
 #endif
 
 
-static struct ac97_pcm ac97_defs[] = {
+static const struct ac97_pcm ac97_defs[] = {
 	[0] = {	/* Front PCM */
 		.exclusive = 1,
 		.r = {
-- 
1.9.1
