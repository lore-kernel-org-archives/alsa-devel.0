From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Thu, 17 Jul 2014 09:44:47 +0200
Message-ID: <20140717074444.GB18640@ulmo>
References: <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
 <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo>
 <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Rob Jones <rob.jones@codethink.co.uk>, Rojhalat Ibrahim <imr@rtschenk.de>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 01:28:00PM +0900, Alexandre Courbot wrote:
> On Wed, Jul 16, 2014 at 5:50 PM, Rob Jones <rob.jones@codethink.co.uk> wr=
ote:
> >
> >
> > On 16/07/14 08:51, Thierry Reding wrote:
> >>
> >> On Wed, Jul 16, 2014 at 04:28:33PM +0900, Alexandre Courbot wrote:
> >>>
> >>> On Wed, Jul 16, 2014 at 4:12 PM, Thierry Reding
> >>> <thierry.reding@gmail.com> wrote:
> >>>>
> >>>> On Wed, Jul 16, 2014 at 12:00:45PM +0900, Alexandre Courbot wrote:
> >>>>>
> >>>>> On Tue, Jul 15, 2014 at 6:14 PM, Alexandre Courbot <gnurou@gmail.co=
m>
> >>>>> wrote:
> >>>>>>
> >>>>>> On Tue, Jul 15, 2014 at 4:58 PM, Lars-Peter Clausen <lars@metafoo.=
de>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 07/15/2014 09:36 AM, Alexandre Courbot wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Tue, Jul 15, 2014 at 4:19 PM, Arnd Bergmann <arnd@arndb.de>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On Monday 14 July 2014 19:36:24 Mark Brown wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>> Yes. But now that you say it the gpiod_direction_output() ca=
ll
> >>>>>>>>>>>> is
> >>>>>>>>>>>> missing
> >>>>>>>>>>>> from this patch.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from
> >>>>>>>>>>> Documentation/gpio/board.txt
> >>>>>>>>>>> and as Linus Walleij explained to me the other day, the looku=
p is
> >>>>>>>>>>> supposed
> >>>>>>>>>>> to replace devm_gpio_request_one(), which in turn replaced bo=
th
> >>>>>>>>>>> the
> >>>>>>>>>>> gpio_request and the gpio_direction_output(). Do I need to put
> >>>>>>>>>>> the
> >>>>>>>>>>> gpiod_direction_output() back or is there another interface f=
or
> >>>>>>>>>>> that
> >>>>>>>>>>> when
> >>>>>>>>>>> registering the board gpios?
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Indeed.  If you *do* need an explicit _output() then that soun=
ds
> >>>>>>>>>> to me
> >>>>>>>>>> like we either need a gpiod_get_one() or an extension to the
> >>>>>>>>>> table,
> >>>>>>>>>> looking at the code it seems like this is indeed the case.  We=
 can
> >>>>>>>>>> set
> >>>>>>>>>> if the GPIO is active high/low, or open source/drain but there=
's
> >>>>>>>>>> no flag
> >>>>>>>>>> for the initial state.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> (adding Alexandre and the gpio list)
> >>>>>>>>>
> >>>>>>>>> GPIO people: any guidance on how a board file should set a gpio=
 to
> >>>>>>>>> output/default-high in a GPIO_LOOKUP() table to replace a
> >>>>>>>>> devm_gpio_request_one() call in a device driver with
> >>>>>>>>> devm_gpiod_get()?
> >>>>>>>>> Do we need to add an interface extension to do this, e.g. passi=
ng
> >>>>>>>>> GPIOF_OUT_INIT_HIGH as the flags rather than GPIO_ACTIVE_HIGH?
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> The way I see it, GPIO mappings (whether they are done using the
> >>>>>>>> lookup tables, DT, or ACPI) should only care about details that =
are
> >>>>>>>> relevant to the device layout and that should be abstracted to t=
he
> >>>>>>>> driver (e.g. whether the GPIO is active low or open drain) so
> >>>>>>>> drivers
> >>>>>>>> do not need to check X conditions every time they want to drive =
the
> >>>>>>>> GPIO.
> >>>>>>>>
> >>>>>>>> Direction and initial value, on the other hand, are clearly
> >>>>>>>> properties
> >>>>>>>> that ought to be set by the driver itself. Thus my expectation h=
ere
> >>>>>>>> would be that the driver sets the GPIO direction and initial val=
ue
> >>>>>>>> as
> >>>>>>>> soon as it gets it using gpiod_direction_output(). In other word=
s,
> >>>>>>>> there is no replacement for gpio_request_one() with the gpiod
> >>>>>>>> interface. Is there any use-case that cannot be covered by calli=
ng
> >>>>>>>> gpiod_direction_output() right after gpiod_get()? AFAICT this is
> >>>>>>>> what
> >>>>>>>> gpio_request_one() was doing anyway.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> I agree with you that this is something that should be done in the
> >>>>>>> driver
> >>>>>>> and not in the lookup table. I think that it is still a good idea=
 to
> >>>>>>> have a
> >>>>>>> replacement for gpio_request_one with the new GPIO descriptor API=
=2E A
> >>>>>>> large
> >>>>>>> share of the drivers want to call either gpio_direction_input() or
> >>>>>>> gpio_direction_output() right after requesting the GPIO. Combining
> >>>>>>> both the
> >>>>>>> requesting and the configuration of the GPIO into one function ca=
ll
> >>>>>>> makes
> >>>>>>> the code a bit shorter and also simplifies the error handling. Ev=
en
> >>>>>>> more so
> >>>>>>> if e.g. the GPIO is optional. This was one of the main reasons why
> >>>>>>> gpio_request_one was introduced, see the commit[1] that added it.
> >>>>>>
> >>>>>>
> >>>>>> I am not opposed to it as a convenience function. Note that since =
the
> >>>>>> open-source and open-drain flags are already handled by the lookup
> >>>>>> table, the only flags it should handle are those related to direct=
ion,
> >>>>>> value, and (maybe) sysfs export.
> >>>>>
> >>>>>
> >>>>> Problem is, too much convenience functions seems to ultimately kill
> >>>>> convenience.
> >>>>>
> >>>>> The canonical way to request a GPIO is by providing a (device,
> >>>>> function, index) triplet to gpiod_get_index(). Since most functions
> >>>>> only need one GPIO, we have gpiod_get(device, function) which is
> >>>>> basically an alias to gpiod_get_index(device, function, 0) (note to
> >>>>> self: we should probably inline it).
> >>>>>
> >>>>> On top of these comes another set of convenience functions,
> >>>>> gpiod_get_optional() and gpiod_get_index_optional(), which return N=
ULL
> >>>>> instead of -ENOENT if the requested GPIO mapping does not exist. Th=
is
> >>>>> is useful for the common case where a driver can work without a GPI=
O.
> >>>>>
> >>>>> Of course these functions all have devm counterparts, so we current=
ly
> >>>>> have 8 (devm_)gpiod_get(_index)(_optional) functions.
> >>>>>
> >>>>> If we are to add functions with an init flags parameter, we will end
> >>>>> with 16 functions. That starts to be a bit too much to my taste, and
> >>>>> maybe that's where GPIO consumers should sacrifice some convenience=
 to
> >>>>> preserve a comprehensible GPIO API.
> >>>>>
> >>>>> There might be other ways to work around this though. For instance,=
 we
> >>>>> could replace the _optional functions by a GPIOF_OPTIONAL flag to be
> >>>>> passed to a more generic function that would also accept direction =
and
> >>>>> init value flags. Actually I am not seeing any user of the _optional
> >>>>> variant in -next, so maybe we should just do this. Thierry, since y=
ou
> >>>>> introduced the _optional functions, can we get your thoughts about
> >>>>> this?
> >>>>
> >>>>
> >>>> I personally prefer explicit naming of the functions rather than put=
ting
> >>>> a bunch of flags into some parameter. If you're overly concerned abo=
ut
> >>>> the amount of convenience functions, perhaps the _index variants can=
 be
> >>>> left out for gpiod_get_one(). I'd argue that if drivers want to deal
> >>>> with that level of detail anyway, they may just as well add the index
> >>>> explicitly when calling the function.
> >>>>
> >>>> While we're at it, gpiod_get_one() doesn't sound like a very good na=
me.
> >>>> All other variants only request "one" as well. Perhaps something like
> >>>> gpiod_get_with_flags() would be a better name.
> >>>>
> >>>> Then again, maybe rather than add a new set of functions we should b=
ite
> >>>> the bullet and change gpiod_get() (and variants) to take an addition=
al
> >>>> flags parameter. There aren't all that many users yet (I count 26
> >>>> outside of drivers/gpio), so maybe now would still be a good time to=
 do
> >>>> that.
> >>>
> >>>
> >>> That sounds reasonable indeed. And preferable to getting an aneurysm
> >>> after trying to spell devm_gpiod_get_index_optional_with_flags().
> >>>
> >>> This also makes the most sense since most GPIO users will want to set
> >>> a direction and value right after obtaining one. So if there is no
> >>> objection I will probably start refactoring gpiod_get() this week.
> >>
> >>
> >> Sounds good to me.
> >>
> >
> > In light of this, should I hold off starting on devm_gpiod_get_array()
> > as discussed on here last week?
>=20
> These are two independant issues, and adapting the get_array() patch
> to a refactored gpiod_get() should be trivial.
>=20
> But while we are at it (and sorry for going further off-topic), I also
> think that gpiod_get_array() should not follow the same calling
> convention as gpio_request_array() by taking an array of whatever
> gpiod_get() would require. Instead, I think it should be redefined to
> mean "get all the GPIOs for a given function". For instance, say that
> in the DT you have
>=20
> foo-gpios =3D <&gpio 0 GPIO_ACTIVE_HIGH &gpio 1 GPIO_ACTIVE_HIGH &gpio 2
> GPIO_ACTIVE_HIGH>;
>=20
> Then gpiod_get_array(dev, "foo", &num) should return descriptors to
> these 3 GPIOs and assign "3" to num. The same thing can be done with
> the platform lookup tables.
>=20
> Actually it would be even better if this API could be designed to
> interact nicely with the multiple GPIO setting patch by Rojhalat:
> http://www.spinics.net/lists/linux-gpio/msg00827.html
>=20
> gpiod_get_array() would thus allocate and return an array of GPIO
> descriptors suitable to be used immediatly with gpiod_set_array(). And
> bam, a nice full-circle API for handling multiple GPIOs. My
> expectations have risen all of a sudden. ;)

Should the new gpiod_get_array() function also have a way to specify the
flags similar to gpiod_get()? I agree that making it return all GPIOs of
a given function is a good idea. And given that GPIOs associated with
the same function probably behave very similarly it should be safe to
add flags handling to that as well. That is, I don't think we'd need to
worry about different GPIOs of the same function requiring different
directions or initial values (note that polarity is still handled by the
GPIO specifier).

Thierry

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx37sAAoJEN0jrNd/PrOhZ1EQAIzJtZiSgHZtXuNBtqQ+GzhW
he8ttdypKbax3KIJGe3x8GMfm+9plxZdWmNxicXJNRz4kSRzeII0r2c4qD+ueL3H
4iGfguvgYK3aDDoY9HKUbP51tH7mjp41v/qVXRWgAtl/4qOjQel+dAzr9WBw/HiO
//ezkXHxJPTZNKub9owixMqA1zbCxUedYDmkhN/GtcFuVTNcpI47p4Ie47+Br37b
/XLROJ5JAicIeYuh9RUak9AFAxJ2z/3ENjUC/0bgDTp5D+77y8VFTCFH+wQrP5lV
RN/Mb9TOtXqqnKtzRDZqqtEvqDxO/VYvnue4f7qN2A6ZWogUvGeQXO/9YInEOIRy
X9Alt8lO+XVpRuoabcqRf41MNvCMKnMHReFN3Bm6eLtnm9T7xmDGppUgEc6FXUSk
h9WWB4VojYl68RSH+039CwVnnbPX3MNH49UD4/s0SHsm4vBhJwimiqr5crE8onab
9ViIBMQSyUtBBoCcyn2wHc5wjZWhib+lCZ491Q9AKas9Pxh5t5Wl5Sgvijz+5yAv
UUfufLO/mtBd40DTXdFKdOQvzDt0J0ZG4KaZoEShSccuvPvkKh/6lhZY6sQsquqg
HouztPTqVGvwZ1Xooe+P83qVi3sjTnzdQ+GMbcVNmVnqyhSW5B7GWZneqiAcD3Tw
owXFK1Q59pGl1lOsp15M
=LtmC
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
