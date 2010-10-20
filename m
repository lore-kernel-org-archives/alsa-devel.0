From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Tue, 19 Oct 2010 21:01:42 -0700
Message-ID: <20101020040141.GA22078@opensource.wolfsonmicro.com>
References: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
	<20101019093550.GA11371@opensource.wolfsonmicro.com>
	<AANLkTimaQ=7Ejgb1jZW4=VGj2-ZV-2wcX6esZwUXsC4a@mail.gmail.com>
	<20101020031333.GH3803@opensource.wolfsonmicro.com>
	<AANLkTi=5i=51=-m3ZhbTOWyQKz8H3oam6V=QfjL1DxhM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 987322451A
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 06:01:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=5i=51=-m3ZhbTOWyQKz8H3oam6V=QfjL1DxhM@mail.gmail.com>
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

On Wed, Oct 20, 2010 at 12:27:43PM +0900, Jassi Brar wrote:
> On Wed, Oct 20, 2010 at 12:13 PM, Mark Brown

> > If we have something in the driver data struct specifying the masks to
> > use then set these at probe time rather than having the if statements -
> > probably the same mask can be used for playback & record if the
> > bitfields are lined up similarly. =A0This would then be:

> > =A0 =A0 =A0 =A0con |=3D data->active_mask;
> > =A0 =A0 =A0 =A0con &=3D ~data->pause_mask;

> > or similar, possibly with some shifts.

> Let me see if the space saved is worth the complication.

I was thinking it should make something similar by making it clear that
we're just doing the same thing to a different location rather than lots
of conditional code to follow.

> > Please add a comment explaining that you're inverting the orientation
> > you set previously - it's really surprising when reading the code.

> Ok, I'll add a comment.
> Btw, isn't it the standard way? Don't other I2S CPU drivers do the same t=
hing ?

Not commonly - normally people don't implement anything except plain I2S
mode, or have explict mode and inversion bits (so the mode sets the
expected polarity and then the inversion bit swaps that).

> > How would the index be used with multi-component?

> For example, please look at [Patch 23/25]

> +               /* Secondary is at offset MAX_I2S from Primary */
> +               str =3D (char *)smdk_dai[SEC_PLAYBACK].cpu_dai_name;
> +               str[strlen(str) - 1] =3D '0' + MAX_I2S;

Hrm, slightly fiddly.  Perhaps we want a function people can call which
will generate the secondary DAI name for you?  Might be more directly
what people want.
