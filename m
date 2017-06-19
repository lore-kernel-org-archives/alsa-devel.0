From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] ALSA: sound/isa: constify snd_ratnum structures
Date: Tue, 20 Jun 2017 00:11:53 +0530
Message-ID: <1497897714-27522-2-git-send-email-bhumirks@gmail.com>
References: <1497897714-27522-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497897714-27522-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_ratnum structures as const as their reference is only
stored in the rate field of a snd_pcm_hw_constraint_ratnums structure.
This field is of type const, so snd_ratnum structures can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/isa/gus/gus_pcm.c | 2 +-
 sound/isa/sb/sb8_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 33c1891..95df8ca 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -547,7 +547,7 @@ static snd_pcm_uframes_t snd_gf1_pcm_playback_pointer(struct snd_pcm_substream *
 	return pos;
 }
 
-static struct snd_ratnum clock = {
+static const struct snd_ratnum clock = {
 	.num = 9878400/16,
 	.den_min = 2,
 	.den_max = 257,
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 9043397..2491655 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -46,7 +46,7 @@ MODULE_LICENSE("GPL");
 #define SB8_DEN(v)	((SB8_CLOCK + (v) / 2) / (v))
 #define SB8_RATE(v)	(SB8_CLOCK / SB8_DEN(v))
 
-static struct snd_ratnum clock = {
+static const struct snd_ratnum clock = {
 	.num = SB8_CLOCK,
 	.den_min = 1,
 	.den_max = 256,
-- 
2.7.4
