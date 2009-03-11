From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't use
	SSCR0_SerClkDiv and SSCR0_SCR
Date: Wed, 11 Mar 2009 22:10:27 +0100
Message-ID: <74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
	<20090311184416.GA29865@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7169D243E3
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 22:10:28 +0100 (CET)
Received: by gxk2 with SMTP id 2so484660gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 14:10:27 -0700 (PDT)
In-Reply-To: <20090311184416.GA29865@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 7:44 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Wed, Mar 11, 2009 at 07:17:00PM +0100, Philipp Zabel wrote:
>> As soon as CONFIG_PXA25x is enabled, those macros only handle the PXA25x=
_SSP
>> case, which is wrong most of the time (and always wrong on >=3DPXA27x).
>
> Ah, I just (while reading this header file) wondered how this is
> supposed to work :)
>
>> @@ -287,10 +287,17 @@ static void ssp_set_scr(struct ssp_priv *priv, u32=
 div)
>> =A0{
>> =A0 =A0 =A0 struct ssp_dev *dev =3D &priv->dev;
>> =A0 =A0 =A0 struct ssp_device *ssp =3D dev->ssp;
>> - =A0 =A0 u32 sscr0 =3D ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
>> + =A0 =A0 u32 sscr0 =3D ssp_read_reg(dev->ssp, SSCR0);
>>
>> =A0 =A0 =A0 priv->scr_div =3D div;
>> - =A0 =A0 ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
>> + =A0 =A0 if (ssp->type =3D=3D PXA25x_SSP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sscr0 &=3D ~0x0000ff00; =A0 =A0 =A0 =A0/* SSCR=
0_SCR */
>> + =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D ((div - 2)/2) << 8; /* SSCR0_SerClk=
Div(div) */
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sscr0 &=3D ~0x000fff00; =A0 =A0 =A0 =A0/* SSCR=
0_SCR */
>> + =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D (div - 1) << 8; =A0 =A0 /* SSCR0_Se=
rClkDiv(div) */
>> + =A0 =A0 }
>> + =A0 =A0 ssp_write_reg(ssp, SSCR0, sscr0);
>> =A0}
>
> Then we need something like ssp_get_scr() as well to cover my special
> case which uses SSCR0_SCR and SSCR0_SerClkDiv() again as you proposed ;)

Aren't I clever... How about something like this:

---
 sound/soc/pxa/pxa-ssp.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3cde686..245063b 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -284,9 +284,30 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 static void ssp_set_scr(struct ssp_dev *dev, u32 div)
 {
 	struct ssp_device *ssp =3D dev->ssp;
-	u32 sscr0 =3D ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
+	u32 sscr0 =3D ssp_read_reg(ssp, SSCR0);
+
+	if (cpu_is_pxa25x() && ssp->type =3D=3D PXA25x_SSP) {
+		sscr0 &=3D ~0x0000ff00;
+		sscr0 |=3D ((div - 2)/2) << 8;
+	} else {
+		sscr0 &=3D ~0x000fff00;
+		sscr0 |=3D (div - 1) << 8;
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+}

-	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
+/**
+ * ssp_get_clkdiv - get SSP clock divider
+ */
+static u32 ssp_get_scr(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp =3D dev->ssp;
+	u32 sscr0 =3D ssp_read_reg(ssp, SSCR0);
+
+	if (cpu_is_pxa25x() && ssp->type =3D=3D PXA25x_SSP)
+		return ((sscr0 >> 8) & 0xff) * 2 + 2;
+	else
+		return ((sscr0 >> 8) & 0xfff) + 1;
 }

 /*
@@ -668,8 +689,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_I2S:
 	       sspsp =3D ssp_read_reg(ssp, SSPSP);

-		if (((sscr0 & SSCR0_SCR) =3D=3D SSCR0_SerClkDiv(4)) &&
-		     (width =3D=3D 16)) {
+		if (ssp_get_scr(ssp) =3D=3D 4) && (width =3D=3D 16)) {
 			/* This is a special case where the bitclk is 64fs
 			* and we're not dealing with 2*32 bits of audio
 			* samples.
-- =

1.6.2
