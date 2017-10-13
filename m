From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] sound: oss: make audio_driver structure const
Date: Fri, 13 Oct 2017 19:16:33 +0200
Message-ID: <1507914993-6015-3-git-send-email-bhumirks@gmail.com>
References: <1507914993-6015-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507914993-6015-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a followup patch for [PATCH 1/2].

Make these structures const as they are only passed to the const
argument of the function sound_install_audiodrv.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/oss/pas2_pcm.c   | 2 +-
 sound/oss/waveartist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/pas2_pcm.c b/sound/oss/pas2_pcm.c
index 474803b..716c5c4 100644
--- a/sound/oss/pas2_pcm.c
+++ b/sound/oss/pas2_pcm.c
@@ -356,7 +356,7 @@ static int pas_audio_prepare_for_output(int dev, int bsize, int bcount)
 	return 0;
 }
 
-static struct audio_driver pas_audio_driver =
+static const struct audio_driver pas_audio_driver =
 {
 	.owner			= THIS_MODULE,
 	.open			= pas_audio_open,
diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index 4f0c3a2..7509777 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -826,7 +826,7 @@ static void vnc_configure_mixer(struct wavnc_info *devc,
 	return arg;
 }
 
-static struct audio_driver waveartist_audio_driver = {
+static const struct audio_driver waveartist_audio_driver = {
 	.owner			= THIS_MODULE,
 	.open			= waveartist_open,
 	.close			= waveartist_close,
-- 
1.9.1
