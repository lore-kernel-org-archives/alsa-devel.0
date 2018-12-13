From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: meson: fix do_div warning in spdifin
Date: Thu, 13 Dec 2018 16:44:28 +0100
Message-ID: <20181213154428.6070-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Even if this spdif input driver is only supposed to be used on 64bits
platform, there is possible problem with 32bits and do_div, as reported
by the kbuild robot. Just fix it.

Fixes: 5ce5658375e6 ("ASoC: meson: add axg spdif input")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Mark,

 This fixes the problem reported by kbuild robot [0].
 Sorry for not catching this earlier.

 Regards
 Jerome

 [0]: https://lkml.kernel.org/r/201812132245.lBYydcs3%fengguang.wu@intel.com

 sound/soc/meson/axg-spdifin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index 09f385a2bbba..01b2035fa841 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -146,8 +146,8 @@ static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int base_reg,
 					 unsigned int width)
 {
-	unsigned int offset = mode, rem;
-	unsigned int reg, shift;
+	uint64_t offset = mode;
+	unsigned int reg, shift, rem;
 
 	rem = do_div(offset, num_per_reg);
 
-- 
2.19.2
