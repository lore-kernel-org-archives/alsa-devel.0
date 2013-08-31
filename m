From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/14] ASoC: spdif_transceiver: add output pin widget
Date: Sat, 31 Aug 2013 13:41:36 +0100
Message-ID: <E1VFkUi-0003Ij-2P@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Codecs without any outputs now remain powered down, which means any
paths to these codecs also remain powered down.

Add an always-enabled output pin widget to the spdif transceiver codec.
This enables DAPM to correctly identify that the spdif transceiver is
in use when playback is enabled, which will then allow DAPM to power up
any links from the CPU DAI to the SPDIF transceiver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/codecs/spdif_transciever.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 112a49d..8df8d79 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -27,7 +27,20 @@
 #define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
 
-static struct snd_soc_codec_driver soc_codec_spdif_dit;
+static const struct snd_soc_dapm_widget dit_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("spdif-out"),
+};
+
+static const const struct snd_soc_dapm_route dit_routes[] = {
+	{ "spdif-out", NULL, "Playback" },
+};
+
+static struct snd_soc_codec_driver soc_codec_spdif_dit = {
+	.dapm_widgets = dit_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dit_widgets),
+	.dapm_routes = dit_routes,
+	.num_dapm_routes = ARRAY_SIZE(dit_routes),
+};
 
 static struct snd_soc_dai_driver dit_stub_dai = {
 	.name		= "dit-hifi",
-- 
1.7.4.4
