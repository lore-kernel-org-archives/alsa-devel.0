From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: cs42l51: add multi endpoint support
Date: Fri, 29 Mar 2019 16:37:37 +0100
Message-ID: <1553873857-7423-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com
Cc: benjamin.gaignard@st.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Support multiple endpoints on cs42L51 codec port
when used in of_graph context.

This patch allows to share the codec port between two CPU DAIs.

Example:

STM32MP157C-DK2 board uses CS42L51 audio codec.
This codec is connected to two serial audio interfaces,
which are configured either as rx or tx.

>From AsoC point of view the topolgy is the following:
// 2 CPU DAIs (SAI2A/B), 1 Codec (CS42L51)
Playback: CPU-A-DAI(slave) -> (master)CODEC-DAI/port0
Record:   CPU-B-DAI(slave) <- (master)CODEC-DAI/port0

In the DT two endpoints have to be associated to the codec port:
cs42l51_port: port {
	cs42l51_tx_endpoint: endpoint@0 {
		remote-endpoint = <&sai2a_endpoint>;
	};
	cs42l51_rx_endpoint: endpoint@1 {
		remote-endpoint = <&sai2b_endpoint>;
	};
};

However, when the audio graph card parses the codec nodes, it expects
to find DAI interface indexes matching the endpoints indexes.

The current patch forces the use of DAI id 0 for both endpoints,
which allows to share the codec DAI between the two CPU DAIs
for playback and capture streams respectively.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index fd2bd74024c1..80da3cd73e04 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -464,6 +464,13 @@ static int cs42l51_dai_mute(struct snd_soc_dai *dai, int mute)
 	return snd_soc_component_write(component, CS42L51_DAC_OUT_CTL, reg);
 }
 
+static int cs42l51_of_xlate_dai_id(struct snd_soc_component *component,
+				   struct device_node *endpoint)
+{
+	/* return dai id 0, whatever the endpoint index */
+	return 0;
+}
+
 static const struct snd_soc_dai_ops cs42l51_dai_ops = {
 	.hw_params      = cs42l51_hw_params,
 	.set_sysclk     = cs42l51_set_dai_sysclk,
@@ -526,6 +533,7 @@ static const struct snd_soc_component_driver soc_component_device_cs42l51 = {
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l51_dapm_widgets),
 	.dapm_routes		= cs42l51_routes,
 	.num_dapm_routes	= ARRAY_SIZE(cs42l51_routes),
+	.of_xlate_dai_id	= cs42l51_of_xlate_dai_id,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.7.4
