From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: SOF: Intel: fix spelling mistake "incompatble" -> "incompatible"
Date: Wed,  1 May 2019 11:23:08 +0100
Message-ID: <20190501102308.30390-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a hda_dsp_rom_msg message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b8fc19790f3b..84baf275b467 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -54,7 +54,7 @@ static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
 	{HDA_DSP_ROM_L2_CACHE_ERROR, "error: L2 cache error"},
 	{HDA_DSP_ROM_LOAD_OFFSET_TO_SMALL, "error: load offset too small"},
 	{HDA_DSP_ROM_API_PTR_INVALID, "error: API ptr invalid"},
-	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatble"},
+	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatible"},
 	{HDA_DSP_ROM_UNHANDLED_INTERRUPT, "error: unhandled interrupt"},
 	{HDA_DSP_ROM_MEMORY_HOLE_ECC, "error: ECC memory hole"},
 	{HDA_DSP_ROM_KERNEL_EXCEPTION, "error: kernel exception"},
-- 
2.20.1
