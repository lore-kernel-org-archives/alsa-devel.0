From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: ac97: remove unused variable 'snd_ac97_controls_master_mono'
Date: Fri, 9 Aug 2019 17:01:13 +0800
Message-ID: <20190809090113.65728-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/pci/ac97/ac97_codec.c:599:38: warning:
 snd_ac97_controls_master_mono defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/ac97/ac97_codec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 96b4601..66f6c3b 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -596,11 +596,6 @@ static int snd_ac97_put_volsw(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
-static const struct snd_kcontrol_new snd_ac97_controls_master_mono[2] = {
-AC97_SINGLE("Master Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
-AC97_SINGLE("Master Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1)
-};
-
 static const struct snd_kcontrol_new snd_ac97_controls_tone[2] = {
 AC97_SINGLE("Tone Control - Bass", AC97_MASTER_TONE, 8, 15, 1),
 AC97_SINGLE("Tone Control - Treble", AC97_MASTER_TONE, 0, 15, 1)
-- 
2.7.4
