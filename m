From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8962: Add ALC coefficient support
Date: Fri, 1 Nov 2013 10:02:10 +0000
Message-ID: <20131101100210.GB1901@opensource.wolfsonmicro.com>
References: <20131101100051.GA1901@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131101100051.GA1901@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c9ff713..2b04497 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1774,6 +1774,11 @@ WM8962_DSP2_ENABLE("HPF2 Switch", WM8962_HPF2_ENA_SHIFT),
 SND_SOC_BYTES("HPF Coefficients", WM8962_LHPF2, 1),
 WM8962_DSP2_ENABLE("HD Bass Switch", WM8962_HDBASS_ENA_SHIFT),
 SND_SOC_BYTES("HD Bass Coefficients", WM8962_HDBASS_AI_1, 30),
+
+SOC_DOUBLE("ALC Switch", WM8962_ALC1, WM8962_ALCL_ENA_SHIFT,
+		WM8962_ALCR_ENA_SHIFT, 1, 0),
+SND_SOC_BYTES_MASK("ALC Coefficients", WM8962_ALC1, 4,
+		WM8962_ALCL_ENA_MASK | WM8962_ALCR_ENA_MASK),
 };
 
 static const struct snd_kcontrol_new wm8962_spk_mono_controls[] = {
-- 
1.7.2.5
