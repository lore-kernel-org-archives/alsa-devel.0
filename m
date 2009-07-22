From: "Mani, Arun" <avm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] ASoC: tlv320aic3x: Enable PLL when not bypassed
Date: Wed, 22 Jul 2009 07:39:58 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C011E89804C@dlee02.ent.ti.com>
References: <1248263104-12142-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1248263104-12142-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Subrahmanya, Chaithrika" <chaithrika-l0cyMroinI0@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Chaithrika,
Do you know why it worked in dm644x. I don't see any specific path taken fo=
r the DM644x.

Arun

-----Original Message-----
From: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org [mailto:davinc=
i-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf Of Subrahmanya,=
 Chaithrika
Sent: Wednesday, July 22, 2009 7:45 AM
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; broonie-yzvPICuk2ABfQMn51R22fg@public.gmane.org=
sonmicro.com
Subject: [PATCH] ASoC: tlv320aic3x: Enable PLL when not bypassed

PLL was not being enabled when it was not bypassed. This patch
enables the PLL when it is used. Additionally, it disables the PLL
when it is bypassed.

Without this patch, the audio on TI DM646x EVM and DM355 EVM
does not work properly. The bit clocks and the frame sync signals
from the codec are not correct and hence the playback/record are faster
than usual for most sample rates. The reason for this was that the PLL
was not enabled when it was not bypassed.

Tested on DM6467 EVM, playback tested on DM355 EVM.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
Applies to master branch of ALSA GIT tree at
http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dsummary

 sound/soc/codecs/tlv320aic3x.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.=
c
index ab099f4..cb0d1bf 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -767,6 +767,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *su=
bstream,
 	int codec_clk =3D 0, bypass_pll =3D 0, fsref, last_clk =3D 0;
 	u8 data, r, p, pll_q, pll_p =3D 1, pll_r =3D 1, pll_j =3D 1;
 	u16 pll_d =3D 1;
+	u8 reg;
=20
 	/* select data word length */
 	data =3D
@@ -801,8 +802,16 @@ static int aic3x_hw_params(struct snd_pcm_substream *s=
ubstream,
 		pll_q &=3D 0xf;
 		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
 		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
-	} else
+		/* disable PLL if it is bypassed */
+		reg =3D aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
+
+	} else {
 		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+		/* enable PLL when it is used */
+		reg =3D aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
+	}
=20
 	/* Route Left DAC to left channel input and
 	 * right DAC to right channel input */
--=20
1.5.6

_______________________________________________
Davinci-linux-open-source mailing list
Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
