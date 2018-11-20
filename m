From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei
	WMI micmute LED
Date: Tue, 20 Nov 2018 10:36:10 +0100
Message-ID: <20181120093610.GF16916@amd>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com>
 <20181119235713.GB7367@amd> <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd> <s5hbm6kf6gi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7715393409716985415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6416E26770D
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 10:36:12 +0100 (CET)
In-Reply-To: <s5hbm6kf6gi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ayman Bagabas <ayman.bagabas@gmail.com>, linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>, Kailang Yang <kailang@realtek.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7715393409716985415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 10:23:25, Takashi Iwai wrote:
> On Tue, 20 Nov 2018 10:10:39 +0100,
> Pavel Machek wrote:
> >=20
> > On Tue 2018-11-20 08:07:09, Takashi Iwai wrote:
> > > On Tue, 20 Nov 2018 00:57:13 +0100,
> > > Pavel Machek wrote:
> > > >=20
> > > > > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> > > > > +#include <linux/platform_data/x86/huawei_wmi.h>
> > > > > +
> > > > > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> > > > > +
> > > >=20
> > > > So we should not be doing this.
> > > >=20
> > > > Thinkpad ACPI module exports its LEDs there, for example.
> > >=20
> > > Both thinkpad_acpi and dell_laptop provide the interface to HD-audio
> > > in the very same way like this.
> >=20
> > Not good :-(. Please don't add new ones, general purpose LEDs should
> > really use LED subsystem.
>=20
> What's the problem with this approach?

You have general-purpose LED, yet you are treating it as "something
special". That means ugly code (quoted above) and lack of flexibility.

For example, if my notebook lacks HDD LED, I can use scrollock LED for
that instead. Or, in reverse way, maybe "mic mute" LED is not useful
for me, and I'd like to use it for notifications instead.

(If the LED was driven by hardware, and always reflected microphone
status, that would be different. But that's not the case AFAICT).


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvz1YoACgkQMOfwapXb+vJllwCdHcI/tlhb2dC+Gk2nGzfzl+es
b0AAnj/CkHkP1ohu7choUS40EEKEZE1B
=HdJf
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--

--===============7715393409716985415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7715393409716985415==--
