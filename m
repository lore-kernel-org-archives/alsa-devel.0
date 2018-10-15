From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 4/4] ASoC: cs42l51: add mclk support
Date: Mon, 15 Oct 2018 16:03:36 +0200
Message-ID: <1539612216-12602-5-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE02267737
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 16:03:45 +0200 (CEST)
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add MCLK dapm to allow configuration of cirrus CS42l51
codec as a master clock consumer.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 5080d7a3c279..eb40bff54cec 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -237,6 +237,10 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
 		&cs42l51_adcr_mux_controls),
 };
 
+static const struct snd_soc_dapm_widget cs42l51_dapm_mclk_widgets[] = {
+	SND_SOC_DAPM_CLOCK_SUPPLY("MCLK")
+};
+
 static const struct snd_soc_dapm_route cs42l51_routes[] = {
 	{"HPL", NULL, "Left DAC"},
 	{"HPR", NULL, "Right DAC"},
@@ -487,6 +491,10 @@ static struct snd_soc_dai_driver cs42l51_dai = {
 static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
+	struct snd_soc_dapm_context *dapm;
+
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
-- 
2.7.4
