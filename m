From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/4] ALSA: ac97c: constify ac97_pcm structures
Date: Wed, 23 Aug 2017 17:39:26 +0530
Message-ID: <1503490168-26501-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/atmel/ac97c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 70616da..345b943 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -558,7 +558,7 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 	return retval;
 }
 
-static struct ac97_pcm at91_ac97_pcm_defs[] = {
+static const struct ac97_pcm at91_ac97_pcm_defs[] = {
 	/* Playback */
 	{
 		.exclusive = 1,
-- 
1.9.1
