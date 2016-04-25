From: Jeremy McDermond <nh6z-fFIq/eER6g8@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: simple-card: Add support jack detection via codec
Date: Mon, 25 Apr 2016 11:17:21 -0700
Message-ID: <9CA36836-11FE-4A7B-8DBC-5A4842D004C6@nh6z.net>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com> <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com> <20160421141921.GA25900@rob-hp-laptop> <57197BBA.50304@rock-chips.com> <20160422092250.GA3217@sirena.org.uk> <3C927D46-BC52-4B5C-B5B4-CCBA3AAE6F87@xenotropic.com> <20160425125504.GL3217@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160425125504.GL3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On Apr 25, 2016, at 5:55 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> If the clock code is worth splitting off into a separate driver that'=
s
> what drivers/mfd is for.

I have my doubts that it=E2=80=99s worth splitting off into a separate
driver.  There=E2=80=99s not a lot of use for it outside of the interna=
ls of
the tlv320aic3204.  There is a provision for putting the PLL output
on a GPIO pin of the chip, but I=E2=80=99m not sure that=E2=80=99s a ju=
stification
for breaking out the clock stuff into its own driver.  Nobody=E2=80=99s=
 going
to put a tlv320aic3204 chip on their boards because of the clocking;
they=E2=80=99re going to put it there to be a codec.

--
Jeremy McDermond (NH6Z)
Xenotropic Systems
mcdermj-MdGE8NL7F62ukZHgTAicrQ@public.gmane.org




--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
