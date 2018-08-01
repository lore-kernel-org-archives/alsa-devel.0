From: Colin King <colin.king@canonical.com>
Subject: [PATCH 9/9] ALSA: intel_hdmi: remove redundant variable cfg_val
Date: Wed,  1 Aug 2018 11:47:42 +0100
Message-ID: <20180801104742.4328-10-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jaya Kumar <jayakumar.alsa@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable cfg_val is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'cfg_val' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/x86/intel_hdmi_audio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index edc9f5a34eff..fa7dca5a68c8 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -290,7 +290,6 @@ static void had_reset_audio(struct snd_intelhad *intelhaddata)
 static int had_prog_status_reg(struct snd_pcm_substream *substream,
 			struct snd_intelhad *intelhaddata)
 {
-	union aud_cfg cfg_val = {.regval = 0};
 	union aud_ch_status_0 ch_stat0 = {.regval = 0};
 	union aud_ch_status_1 ch_stat1 = {.regval = 0};
 
@@ -298,7 +297,6 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 					  IEC958_AES0_NONAUDIO) >> 1;
 	ch_stat0.regx.clk_acc = (intelhaddata->aes_bits &
 					  IEC958_AES3_CON_CLOCK) >> 4;
-	cfg_val.regx.val_bit = ch_stat0.regx.lpcm_id;
 
 	switch (substream->runtime->rate) {
 	case AUD_SAMPLE_RATE_32:
-- 
2.17.1
