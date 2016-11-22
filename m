From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC v2 3/3] ASoC: hdmi-codec: Example of PCM control
	bound to PCM device for multi HDMI DAIs.
Date: Tue, 22 Nov 2016 11:53:16 +0100
Message-ID: <1479811996-2238-4-git-send-email-arnaud.pouliquen@st.com>
References: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 071C22669E6
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 11:53:39 +0100 (CET)
In-Reply-To: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

link ELD control to PCM device to support multi instances of the codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/hdmi-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 90b5948..a807c2f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -339,6 +339,8 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 		.sig_bits = 24,
 	},
 	.ops = &hdmi_dai_ops,
+	.pcm_controls = hdmi_controls,
+	.num_pcm_controls = ARRAY_SIZE(hdmi_controls),
 };
 
 static const struct snd_soc_dai_driver hdmi_spdif_dai = {
@@ -381,8 +383,6 @@ static int hdmi_of_xlate_dai_name(struct snd_soc_component *component,
 
 static struct snd_soc_codec_driver hdmi_codec = {
 	.component_driver = {
-		.controls		= hdmi_controls,
-		.num_controls		= ARRAY_SIZE(hdmi_controls),
 		.dapm_widgets		= hdmi_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
 		.dapm_routes		= hdmi_routes,
-- 
1.9.1
