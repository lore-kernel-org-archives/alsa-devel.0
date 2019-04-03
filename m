From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 4/7] ASoC: cs42l51: add support of master mode
Date: Wed, 3 Apr 2019 15:23:34 +0200
Message-ID: <1554297817-14154-5-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.com
List-Id: alsa-devel@alsa-project.org

Add support of master mode for cs42l51 cirrus audio codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 9b3ffa16b204..397b68901d1c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -340,6 +340,19 @@ static struct cs42l51_ratios slave_auto_ratios[] = {
 	{  256, CS42L51_DSM_MODE, 1 }, {  384, CS42L51_DSM_MODE, 1 },
 };
 
+/*
+ * Master mode mclk/fs ratios.
+ * Recommended configurations are SSM for 4-50khz and DSM for 50-100kHz ranges
+ * The table below provides support of following ratios:
+ * 128: SSM (%128) with div2 disabled
+ * 256: SSM (%128) with div2 enabled
+ * In both cases, if sampling rate is above 50kHz, SSM is overridden
+ * with DSM (%128) configuration
+ */
+static struct cs42l51_ratios master_ratios[] = {
+	{ 128, CS42L51_SSM_MODE, 0 }, { 256, CS42L51_SSM_MODE, 1 },
+};
+
 static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -362,11 +375,13 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	unsigned int ratio;
 	struct cs42l51_ratios *ratios = NULL;
 	int nr_ratios = 0;
-	int intf_ctl, power_ctl, fmt;
+	int intf_ctl, power_ctl, fmt, mode;
 
 	switch (cs42l51->func) {
 	case MODE_MASTER:
-		return -EINVAL;
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
 	case MODE_SLAVE:
 		ratios = slave_ratios;
 		nr_ratios = ARRAY_SIZE(slave_ratios);
@@ -402,7 +417,16 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	switch (cs42l51->func) {
 	case MODE_MASTER:
 		intf_ctl |= CS42L51_INTF_CTL_MASTER;
-		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		mode = ratios[i].speed_mode;
+		/* Force DSM mode if sampling rate is above 50kHz */
+		if (rate > 50000)
+			mode = CS42L51_DSM_MODE;
+		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(mode);
+		/*
+		 * Auto detect mode is not applicable for master mode and has to
+		 * be disabled. Otherwise SPEED[1:0] bits will be ignored.
+		 */
+		power_ctl &= ~CS42L51_MIC_POWER_CTL_AUTO;
 		break;
 	case MODE_SLAVE:
 		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
-- 
2.7.4
