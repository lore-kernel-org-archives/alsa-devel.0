From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH 1/2] ASoC: Fix function return type
Date: Tue, 4 Dec 2018 18:33:14 +0000
Message-ID: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson@diasemi.com" <Adam.Thomson@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Function returns -1 on error and the return type
should be int.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 include/sound/soc.h | 2 +-
 sound/soc/soc-io.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de8..591d743 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1341,7 +1341,7 @@ static inline int snd_soc_component_cache_sync(
 /* component IO */
 int snd_soc_component_read(struct snd_soc_component *component,
 	unsigned int reg, unsigned int *val);
-unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+int snd_soc_component_read32(struct snd_soc_component *component,
 				      unsigned int reg);
 int snd_soc_component_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 1ff9175..d08f5b1 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -38,7 +38,7 @@ int snd_soc_component_read(struct snd_soc_component *comp=
onent,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_read);
=20
-unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+int snd_soc_component_read32(struct snd_soc_component *component,
 				      unsigned int reg)
 {
 	unsigned int val;
--=20
1.9.1
