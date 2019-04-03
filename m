From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 7/7] ASoC: cs42l51: add adc volume control
Date: Wed, 3 Apr 2019 15:23:37 +0200
Message-ID: <1554297817-14154-8-git-send-email-olivier.moysan@st.com>
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

Add ADC boost volume control for CS42L51 codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 25f17c0051e4..991e4ebd7a04 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -123,6 +123,7 @@ static const DECLARE_TLV_DB_SCALE(tone_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(aout_tlv, -10200, 50, 0);
 
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 1600, 1600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_boost_tlv, 2000, 2000, 0);
 static const char *chan_mix[] = {
 	"L R",
 	"L+R",
@@ -151,6 +152,8 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_SINGLE("Zero Cross Switch", CS42L51_DAC_CTL, 0, 0, 0),
 	SOC_DOUBLE_TLV("Mic Boost Volume",
 			CS42L51_MIC_CTL, 0, 1, 1, 0, boost_tlv),
+	SOC_DOUBLE_TLV("ADC Boost Volume",
+		       CS42L51_MIC_CTL, 5, 6, 1, 0, adc_boost_tlv),
 	SOC_SINGLE_TLV("Bass Volume", CS42L51_TONE_CTL, 0, 0xf, 1, tone_tlv),
 	SOC_SINGLE_TLV("Treble Volume", CS42L51_TONE_CTL, 4, 0xf, 1, tone_tlv),
 	SOC_ENUM_EXT("PCM channel mixer",
-- 
2.7.4
