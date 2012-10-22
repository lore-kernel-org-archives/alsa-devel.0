From: Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH] check for the kzalloc return value
Date: Mon, 22 Oct 2012 17:05:53 +0400
Message-ID: <1350911153-23647-1-git-send-email-kirjanov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kirjanov@gmail.com
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 sound/pci/als300.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 68c4469..e1f74d4 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -394,6 +394,8 @@ static int snd_als300_playback_open(struct snd_pcm_substream *substream)
 	struct snd_als300_substream_data *data = kzalloc(sizeof(*data),
 								GFP_KERNEL);
 
+	if (!data)
+		return -ENOMEM;
 	snd_als300_dbgcallenter();
 	chip->playback_substream = substream;
 	runtime->hw = snd_als300_playback_hw;
@@ -425,6 +427,8 @@ static int snd_als300_capture_open(struct snd_pcm_substream *substream)
 	struct snd_als300_substream_data *data = kzalloc(sizeof(*data),
 								GFP_KERNEL);
 
+	if (!data)
+		return -ENOMEM;
 	snd_als300_dbgcallenter();
 	chip->capture_substream = substream;
 	runtime->hw = snd_als300_capture_hw;
-- 
1.7.9.5
