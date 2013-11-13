From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Wed, 13 Nov 2013 09:31:16 +0100
Message-ID: <201311130931.16238.jbe@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de> <20131112132441.GG30263@pengutronix.de> <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Timur,

On Tuesday 12 November 2013 21:17:34 Timur Tabi wrote:
> On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de>=
 wrote:
> > No, I don't have access on PowerPC hardware, so I didn't test it on
> > PowerPC.
>
> Can you change the code so that the interrupts are enabled only on
> i.MX?  On PowerPC, the interrupts are used only for debugging.

Hmm, you are right. My patch is partially bogus. It enables the
CCSR_SSI_SIER_TDMAE and CCSR_SSI_SIER_RDMAE bits on demand, but this se=
tting
will be overwritten by the "write_ssi(sier_bits, &ssi->sier);" just a f=
ew
lines below. :(

But this patch works, because it removes the CCSR_SSI_SIER_TDMAE and
CCSR_SSI_SIER_RDMAE from the SIER_FLAGS macro. Its content is set
_unconditionally_ in lines 570 and 575 and is written to the register i=
n line
607. This should hit PowerPC as well.

So, the real (and small) fix is to remove these bits from the SIER_FLAG=
S
macro:

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6b7439..f176e34 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,10 +107,10 @@ static inline void write_ssi_mask(u32 __iomem *ad=
dr, u32 clear, u32 set)
 #endif
=20
 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
+#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | \
 		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
 		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
+		    CCSR_SSI_SIER_RIE | \
 		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
=20
 /**

@Markus: can you please test it on your hardware?

Thanks
jbe

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
