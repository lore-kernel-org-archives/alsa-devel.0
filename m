From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hdmi-codec: make const array hdmi_codec_eld_spk_alloc_bits static
Date: Tue, 11 Jul 2017 15:08:55 +0100
Message-ID: <20170711140855.17634-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Vincent Abriou <vincent.abriou@st.com>, Jon Medhurst <tixy@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate array hdmi_codec_eld_spk_alloc_bits on the stack but
make it static. Makes the object code smaller by over 260 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  10882	   3384	     64	  14330	   37fa	sound/soc/codecs/hdmi-codec.o

After:
   text	   data	    bss	    dec	    hex	filename
  10557	   3440	     64	  14061	   36ed	sound/soc/codecs/hdmi-codec.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 7686a80861f1..509ab513b4b2 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -326,7 +326,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
 {
 	int i;
-	const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
+	static const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
 		[0] = FL | FR, [1] = LFE, [2] = FC, [3] = RL | RR,
 		[4] = RC, [5] = FLC | FRC, [6] = RLC | RRC,
 	};
-- 
2.11.0
