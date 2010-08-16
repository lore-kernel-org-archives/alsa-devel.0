From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 13:21:22 +0100
Message-ID: <20100816122122.GC3276@rakim.wolfsonmicro.main>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTin2DtMjwgdiTnxuu+W8B2Jgfoo0VWT9EO_Tjikc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3718F2414F
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 14:21:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin2DtMjwgdiTnxuu+W8B2Jgfoo0VWT9EO_Tjikc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 16, 2010 at 01:16:15PM +0900, Seungwhan Youn wrote:
> On Sat, Aug 14, 2010 at 4:35 AM, Mark Brown

So, this is a great example of a general problem with your mails: you're
generally very light on detail.  This makes it hard to work out exactly
what you're talking about.  This applies to both regular e-mails and
also patches where your descriptions also tend towards the terse.

> > + =A0 =A0 =A0 switch (dai->driver->id) {
> > + =A0 =A0 =A0 case WM8580_DAI_PAIFTX:
> =

>     should be  WM8580_DAI_PAIFRX:

> Because, WM8580_DAI_PAIFTX --> Capture --> ADC.

Gah, right.

> > + =A0 =A0 =A0 return snd_soc_update_bits(codec, WM8580_CLKSEL, sel, sel=
_mask);

> Seems the value and mask arguments are swapped ?

Yup.
