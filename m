From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/9] ALSA: emu8000: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:04 +0530
Message-ID: <1502452687-8202-7-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/sb/emu8000_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 2ee8d67..9409827 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -670,7 +670,7 @@ static snd_pcm_uframes_t emu8k_pcm_pointer(struct snd_pcm_substream *subs)
 }
 
 
-static struct snd_pcm_ops emu8k_pcm_ops = {
+static const struct snd_pcm_ops emu8k_pcm_ops = {
 	.open =		emu8k_pcm_open,
 	.close =	emu8k_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
