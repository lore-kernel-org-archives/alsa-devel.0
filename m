From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/13] ALSA: parisc: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:15 +0530
Message-ID: <19589e15b10f062109b5e90c9c253aefb2d3819c.1503040251.git.arvind.yadav.cs@gmail.com>
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
 sound/parisc/harmony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 5911eb3..7bf43e9 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -596,7 +596,7 @@
 	return snd_pcm_lib_free_pages(ss);
 }
 
-static struct snd_pcm_ops snd_harmony_playback_ops = {
+static const struct snd_pcm_ops snd_harmony_playback_ops = {
 	.open =	snd_harmony_playback_open,
 	.close = snd_harmony_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -607,7 +607,7 @@
  	.pointer = snd_harmony_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_harmony_capture_ops = {
+static const struct snd_pcm_ops snd_harmony_capture_ops = {
         .open = snd_harmony_capture_open,
         .close = snd_harmony_capture_close,
         .ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
