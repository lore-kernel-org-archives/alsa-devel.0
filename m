From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: No need to update_bits when writing AEC clock control
Date: Tue, 26 Apr 2016 17:06:20 +0100
Message-ID: <1461686780-22885-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The bits in the ARIZONA_CLOCK_CONTROL register only respond to writes of
a '1', a write of '0' is ignored. So there's no need to use update_bits.
We can do a simple write to set bits.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0cd27e0..e255740 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1126,7 +1126,6 @@ int arizona_anc_ev(struct snd_soc_dapm_widget *w,
 		   int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	unsigned int mask = 0x3 << w->shift;
 	unsigned int val;
 
 	switch (event) {
@@ -1140,7 +1139,7 @@ int arizona_anc_ev(struct snd_soc_dapm_widget *w,
 		return 0;
 	}
 
-	snd_soc_update_bits(codec, ARIZONA_CLOCK_CONTROL, mask, val);
+	snd_soc_write(codec, ARIZONA_CLOCK_CONTROL, val);
 
 	return 0;
 }
-- 
1.9.1
