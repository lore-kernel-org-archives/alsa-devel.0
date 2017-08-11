From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/9] ALSA: es18xx: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:01 +0530
Message-ID: <1502452687-8202-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/es18xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index ae17a65..77023e4 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1665,7 +1665,7 @@ static int snd_es18xx_probe(struct snd_es18xx *chip,
 	return snd_es18xx_initialize(chip, mpu_port, fm_port);
 }
 
-static struct snd_pcm_ops snd_es18xx_playback_ops = {
+static const struct snd_pcm_ops snd_es18xx_playback_ops = {
 	.open =		snd_es18xx_playback_open,
 	.close =	snd_es18xx_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1676,7 +1676,7 @@ static int snd_es18xx_probe(struct snd_es18xx *chip,
 	.pointer =	snd_es18xx_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_es18xx_capture_ops = {
+static const struct snd_pcm_ops snd_es18xx_capture_ops = {
 	.open =		snd_es18xx_capture_open,
 	.close =	snd_es18xx_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
