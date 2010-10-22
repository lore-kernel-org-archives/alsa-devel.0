From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Fri, 22 Oct 2010 08:28:59 -0700
Message-ID: <20101022152859.GA16521@opensource.wolfsonmicro.com>
References: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
	<20101019093550.GA11371@opensource.wolfsonmicro.com>
	<AANLkTimaQ=7Ejgb1jZW4=VGj2-ZV-2wcX6esZwUXsC4a@mail.gmail.com>
	<20101020031333.GH3803@opensource.wolfsonmicro.com>
	<AANLkTi=5i=51=-m3ZhbTOWyQKz8H3oam6V=QfjL1DxhM@mail.gmail.com>
	<20101020040141.GA22078@opensource.wolfsonmicro.com>
	<AANLkTim_TzmtZq1oPdu9tLvypB5PBdyPNE9Lx0L+d2BW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82B3B103817
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:29:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim_TzmtZq1oPdu9tLvypB5PBdyPNE9Lx0L+d2BW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 22, 2010 at 04:39:05PM +0900, Jassi Brar wrote:
> On Wed, Oct 20, 2010 at 1:01 PM, Mark Brown

> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Secondary is at offset MAX_I2S from P=
rimary */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D (char *)smdk_dai[SEC_PLAYBACK].c=
pu_dai_name;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 str[strlen(str) - 1] =3D '0' + MAX_I2S;

> > Hrm, slightly fiddly. =A0Perhaps we want a function people can call whi=
ch
> > will generate the secondary DAI name for you? =A0Might be more directly
> > what people want.

> We already have to decide on platform_device's id in probe while creating=
 the
> secondary dai in CPU driver. So there must exist any such predefined offs=
et in
> the common driver.
> So, I decided to reuse the symbol and save one addition to the API.

Would it not be nicer to give a different name to the DAI?
