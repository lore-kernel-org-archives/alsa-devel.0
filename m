From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/7] ALSA: ali5451: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:32 +0530
Message-ID: <1502365658-24723-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/ali5451/ali5451.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 8567f1e..39547e3 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1540,7 +1540,7 @@ static int snd_ali_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ali_playback_ops = {
+static const struct snd_pcm_ops snd_ali_playback_ops = {
 	.open =		snd_ali_playback_open,
 	.close =	snd_ali_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1551,7 +1551,7 @@ static int snd_ali_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_ali_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_ali_capture_ops = {
+static const struct snd_pcm_ops snd_ali_capture_ops = {
 	.open =		snd_ali_capture_open,
 	.close =	snd_ali_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1626,7 +1626,7 @@ static int snd_ali_modem_capture_open(struct snd_pcm_substream *substream)
 	return snd_ali_modem_open(substream, 1, ALI_MODEM_IN_CHANNEL);
 }
 
-static struct snd_pcm_ops snd_ali_modem_playback_ops = {
+static const struct snd_pcm_ops snd_ali_modem_playback_ops = {
 	.open =		snd_ali_modem_playback_open,
 	.close =	snd_ali_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1637,7 +1637,7 @@ static int snd_ali_modem_capture_open(struct snd_pcm_substream *substream)
 	.pointer =	snd_ali_pointer,
 };
 
-static struct snd_pcm_ops snd_ali_modem_capture_ops = {
+static const struct snd_pcm_ops snd_ali_modem_capture_ops = {
 	.open =		snd_ali_modem_capture_open,
 	.close =	snd_ali_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1653,8 +1653,8 @@ struct ali_pcm_description {
 	char *name;
 	unsigned int playback_num;
 	unsigned int capture_num;
-	struct snd_pcm_ops *playback_ops;
-	struct snd_pcm_ops *capture_ops;
+	const struct snd_pcm_ops *playback_ops;
+	const struct snd_pcm_ops *capture_ops;
 	unsigned short class;
 };
 
-- 
1.9.1
