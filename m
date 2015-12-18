From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc
Date: Fri, 18 Dec 2015 21:01:57 +0100
Message-ID: <1450468917-32150-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

This is an API consolidation only. The use of kmalloc + memset to 0
is equivalent to kzalloc.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Found by coccinelle script (relaxed version of
scripts/coccinelle/api/alloc/kzalloc-simple.cocci)

Patch was compile tested with: x86_64_defconfig
CONFIG_SND_PCM_OSS=y

Patch is against linux-next (localversion-next is -next-20150518)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e557dbe..8cdd06f 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -850,7 +850,7 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream)
 
 	if (mutex_lock_interruptible(&runtime->oss.params_lock))
 		return -EINTR;
-	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
+	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
 	if (!sw_params || !params || !sparams) {
@@ -988,7 +988,6 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream)
 		goto failure;
 	}
 
-	memset(sw_params, 0, sizeof(*sw_params));
 	if (runtime->oss.trigger) {
 		sw_params->start_threshold = 1;
 	} else {
-- 
1.7.10.4
