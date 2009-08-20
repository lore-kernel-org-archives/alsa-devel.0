From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v2 2/4] Add ak464x codec support
Date: Thu, 20 Aug 2009 19:58:36 +0100
Message-ID: <20090820185835.GE5032@sirena.org.uk>
References: <uws4yd793.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <uws4yd793.wl%morimoto.kuninori@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 09:01:12PM +0900, Kuninori Morimoto wrote:
> This is very simple driver for ALSA
> It supprt headphone output and stereo input only
> This patch is tested by ms7724se

Thanks, this looks good but it needs updating for a recent change in th=
e
current ASoC tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git f=
or-2.6.32

sound/soc/codecs/ak4642.c: In function =E2=80=98ak4642_read=E2=80=99:
sound/soc/codecs/ak4642.c:130: warning: passing argument 2 of =E2=80=98=
codec->hw_read=E2=80=99 makes integer from pointer without a cast
sound/soc/codecs/ak4642.c:130: error: too many arguments to function =E2=
=80=98codec->hw_read=E2=80=99
sound/soc/codecs/ak4642.c: In function =E2=80=98ak4642_init=E2=80=99:
sound/soc/codecs/ak4642.c:332: warning: assignment from incompatible po=
inter type

Also, a couple of minor issues:

> +static const struct i2c_device_id ak4642_i2c_id[] =3D {
> +	{ "ak4642", 0 },
> +	{ }
> +};

Since the ak4643 is also supported you should add an entry for it to
this table.

> +struct ak4642_setup_data {
> +	int            i2c_bus;
> +	unsigned short i2c_address;
> +};

This struct isn't used any more and so should be removed.
