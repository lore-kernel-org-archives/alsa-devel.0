From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/7] ALSA: trident: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:38 +0530
Message-ID: <1502365658-24723-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/pci/trident/trident_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 64d3b8e..4561040 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2093,7 +2093,7 @@ static int snd_trident_foldback_close(struct snd_pcm_substream *substream)
 	.page =		snd_pcm_sgbuf_ops_page,
 };
 
-static struct snd_pcm_ops snd_trident_capture_ops = {
+static const struct snd_pcm_ops snd_trident_capture_ops = {
 	.open =		snd_trident_capture_open,
 	.close =	snd_trident_capture_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2104,7 +2104,7 @@ static int snd_trident_foldback_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_trident_capture_pointer,
 };
 
-static struct snd_pcm_ops snd_trident_si7018_capture_ops = {
+static const struct snd_pcm_ops snd_trident_si7018_capture_ops = {
 	.open =		snd_trident_capture_open,
 	.close =	snd_trident_capture_close,
 	.ioctl =	snd_trident_ioctl,
-- 
1.9.1
