From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 05/13] ALSA: firewire: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:13 +0530
Message-ID: <1503042321-26758-6-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/firewire/isight.c        | 2 +-
 sound/firewire/motu/motu-pcm.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 48d6dca..5826aa8 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -444,7 +444,7 @@ static snd_pcm_uframes_t isight_pointer(struct snd_pcm_substream *substream)
 
 static int isight_create_pcm(struct isight *isight)
 {
-	static struct snd_pcm_ops ops = {
+	static const struct snd_pcm_ops ops = {
 		.open      = isight_open,
 		.close     = isight_close,
 		.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index a2b50df..1466e46 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -352,7 +352,7 @@ static int playback_ack(struct snd_pcm_substream *substream)
 
 int snd_motu_create_pcm_devices(struct snd_motu *motu)
 {
-	static struct snd_pcm_ops capture_ops = {
+	static const struct snd_pcm_ops capture_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
@@ -365,7 +365,7 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
-	static struct snd_pcm_ops playback_ops = {
+	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-- 
1.9.1
