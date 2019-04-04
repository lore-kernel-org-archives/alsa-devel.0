From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l51: add adc volume control" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:17 +0700 (+07)
Message-ID: <20190404135817.E959C441D3B@finisterre.ee.mobilebroadband>
References: <1554297817-14154-8-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554297817-14154-8-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, apatard@mandriva.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l51: add adc volume control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e04232c38190ec4485c62ceff94cf2b1c0caba20 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:37 +0200
Subject: [PATCH] ASoC: cs42l51: add adc volume control

Add ADC boost volume control for CS42L51 codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index b8f43858876a..58ece037d944 100644
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
2.20.1
