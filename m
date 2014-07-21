From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Mon, 21 Jul 2014 11:04:12 +0100
Message-ID: <20140721100412.GT17528@sirena.org.uk>
References: <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
 <20140717104121.GF17877@ulmo>
 <20140717110540.GS17528@sirena.org.uk>
 <CAAVeFuKQuvTH=5U8chZeMNLjCkfo78+_r2Gx5WUfy+q3F4QZpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5141549721771214540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1C18265163
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 12:04:39 +0200 (CEST)
In-Reply-To: <CAAVeFuKQuvTH=5U8chZeMNLjCkfo78+_r2Gx5WUfy+q3F4QZpQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Rojhalat Ibrahim <imr@rtschenk.de>, Arnd Bergmann <arnd@arndb.de>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Rob Jones <rob.jones@codethink.co.uk>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5141549721771214540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N/EvDld9rH7KvG42"
Content-Disposition: inline


--N/EvDld9rH7KvG42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2014 at 12:36:43PM +0900, Alexandre Courbot wrote:
> On Thu, Jul 17, 2014 at 8:05 PM, Mark Brown <broonie@kernel.org> wrote:

> > For set and get, sure - but it's still useful to be able to do bulk
> > requests for GPIOs especially since that's the only bit of the interface
> > that requires error handling.

> I foresee many problems if people start using gpiod_array_get() as a
> way to spare a few lines of error-checking code. First all the GPIOs
> would end into an array instead of members with meaningful names -
> unless they are moved later on, but doing so would add extra code and
> somewhat kill the purpose. It also becomes more difficult to maintain
> as you are dealing with array indexes to update all over the code.

You just need a few defines for the names, it's not a big deal.

> Finally, it will make it more difficult to use gpiod_array_*() the way
> it is intended to be used, as you would have to discriminate between
> GPIOs of the same function and the rest by yourself.

Yes, you probably shouldn't mix and match here but that's fine.

> Also, if such a convenience function is legitimate for GPIO, shouldn't
> it also apply to other sub-systems? E.g. regulator_array_get()?

It's certainly a totally reasonable and expected way of using
regulator_bulk_get().

> Maybe I am missing your point, but I still think some error-handling
> code really doesn't hurt here, and the few drivers that would actually
> benefit from a more automated GPIO request error handling can easily
> implement it themselves. Let's keep gpiod_array_*() single-purposed
> and to the point.

I'm not sure I see the massive complication TBH - it's not so much about
complexity as it is about reducing the amount of boilerplate that people
need to get right.

--N/EvDld9rH7KvG42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzOWSAAoJELSic+t+oim95aYQAJxhiq0lMHIGSNpO1v54I8f2
rwpFeIcEvK0ymSAJoGHenAxqYP0DL57bD4JTkYIhtLw3bhc2poNxWtp4ZHoehtTc
LnvkEOwe07+1CenZJYaA5O+hJl74Ehiy9SMt5iznn+HJ/J+7PKhQyBslmY5dO4If
dwCMqC1HJ52d6s9mpiZ/qjTvJxWikkwZCZuHcF9RkLEPNXP7V1l7JDZjjepxEQPP
Jn4Hx+PNndFyt8jQiW0POsVgM+fEroVGhgQcDQRPpYnFO1OGYDSGl/ejsr6J/j4o
Ly+IvabRi/2dQh1CDK4yr5KV7Rge/JUsbX2KYgvJrgYinrppF9o3d73xISTnoVPy
mPzaZQ4ioWXNlwY/w9zors70sNRY8Fpu5VNC8u0+9qFkiP/ls97slbcnW0xruRYz
AgUjpjGOq3hEmFMBjh4w2KNYttRlhR8kl4mIYMaaRFDDjvX3OPKNv38q4WXfvEr3
i9XBvuStxiHGVCinCoovhzvpL/Lq/Pa8aUM8FCeU87bLUxCm3eLyG5XoNPlCgXzU
J/IHyX2Lxz3T9btSX93QwC3lafBtY0AkVfzUvzbpqxf2izlo4xDtErl236uh0ERB
zQl7A1wN5sOivjD28J+fQLlpj1r7fJHD5AjbknV+cQiv/lMdHHRTxtYcfSYeLtAt
OKRpy20tn7zhTPimqhHP
=oNtk
-----END PGP SIGNATURE-----

--N/EvDld9rH7KvG42--

--===============5141549721771214540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5141549721771214540==--
