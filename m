From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Mon, 18 May 2015 06:47:11 +0200
Message-ID: <20150518044711.GA3401@air.dominikbrodowski.net>
References: <20150517174144.GA17503@light.dominikbrodowski.net>
 <3695901.X9t2lWziuY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3695901.X9t2lWziuY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2015 at 03:01:32AM +0200, Rafael J. Wysocki wrote:
> On Sunday, May 17, 2015 07:41:44 PM Dominik Brodowski wrote:
> > On Thu, May 14, 2015 at 11:55:33 PM Rafael J. Wysocki wrote:
> > > On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> > > > So the only value that would really make sense here is 5.
> >=20
> > > Overall, what about the appended patch instead of your [2-3/4] (modul=
o the
> > > new command line parameter description which is missing here ATM)?
> >=20
> > Well, this approach works as well -- limiting it to an override for jus=
t 5
> > seems reasonable; expanding blacklist.c to also cover this case (even t=
hough
> > it's not a blacklisting per se) isn't worth any discussion.
> >=20
> > Nonetheless, a few specifics:
> >=20
> > > +config ACPI_REV_OVERRIDE_POSSIBLE
> >=20
> > Why should that be a config option at all? The code savings should be
> > really, really tiny;
>=20
> The idea is not about the code savings, but about having a simple way to =
disable
> the whole thing entirely at one point.
>=20
> All of the workarounds under this option *including* the command line swi=
tch
> should be temporary.

Hopefully, yes. But I am not convinced about that yet (see below).

> > and especially in the beginning we might see a few
> > machines where testing the override might seem to be a good idea. So I'd
> > favour having the command line optional, and then only specific quirks
> > behind a config option: For the Dell XPS 13 it makes sense to disable t=
he
> > quirk if userspace can manage i2s sound; for other systems, there may n=
ot be
> > such hope. And as this is a machine-specific decision, I fear that we h=
ave
> > to do CONFIG options for each and every such DMI entry.
>=20
> I'm not sure if we need a config option for Dell in particular.  We can s=
imply
> drop the quirk when it is not necessary any more.

The quirk for the Dell XPS 13 (2015), yes. Once userspace catches up (which
may take _years_). But Matthew was mentioning that "[t]he Inspiron 7437
queries _REV and uses it to modify its EC behaviour, and apparently breaks
on Linux without that." If that is indeed the case, we will need a quirk
for that Inspiron for much, much longer than for the Dell XPS 13 (2015).

Therefore, I see a need to distinguish the quirk for the Dell XPS 13 (2015),
the quirk for the Inspiron 7437 and potential quirks for other systems: Some
may depend on _sound_ userspace being up to date (XPS), some may depend on
_other_ parts of userspace being up to date, and some may be needed for
as long as these systems exist (Inspiron 7437?). And if the userspace for
the XPS is up to date, the quirk for that particular issue may not be needed
any more, while other quirks (such as potentially the one for the 7437) may
still be needed -- that is why I see a need for different CONFIG options.

> > > +#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
> > > +static bool acpi_rev_override;
> > > +
> > > +int __init acpi_rev_override_setup(char *str)
> > > +{
> > > +	acpi_rev_override =3D true;
> > > +	return 1;
> > > +}
> > > +__setup("acpi_rev_override", acpi_rev_override_setup);
> > > +#else
> > > +#define acpi_rev_override	false
> > > +#endif
> >=20
> > Why __setup, and not module_param? Should mean a smaller diffstat...
>=20
> Because it is consistent with the other __setup things done in this file
> (and none of them is a module_param, mind you).

module_param's aren't unusual in drivers/acpi/* and have substantial
advantages IMO, but I also see the issue of consistency -- so if you really
do prefer __setup, I'll use that approach in the next version of the patch.

> > +config ACPI_REV_OVERRIDE_DELL_XPS_13_2015
>=20
> I'm still not seeing the point and this is just !@#$%^&*()_+ ugly.

I _know_ it's ugly. But this whole suggested change of _REV behavior after
3+ years is ugly, and its fallout may very well be considerably larger than
is known at the moment: It all depends on whether there are other platforms
out there which need such quirks, and whether these quirks are needed for
different timeframes than the quirk for the Dell XPS 13 (2015).

Best,
	Dominik

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVWW7PAAoJEJqXYIlMjaMN5UEP/0BtimL09cqb9v+oYI9xqyqN
1wLuo4tV4Qk7QoN266TP0hovKLmjLX7+LkPvd6KJXBnyVFUC8BopVo7fARce8B+j
KUA49G2FbQ5YaBUtZ3w7d0+RZnDUNCUcMfstYrAh5Sehc27ZE+GI8twNZCi74nRw
OzuVuarPAyiLu/zqMxiuyTjteJ+3tuJlGvUqL1M+rXcUDytVw/t0/u34b+BQ6Ast
Nuyc1CMf40+6985zU4SOuWe4je33X8LtjDPkkhg2QegfLnG2nroLto6uX2xQtmtE
GuhAcJNryjI5rrzmXVosuzq2+EUFT6xmqU3gLwB342ZAjKD1kSFu+wEWsI6+WWfi
nd3AbEcYoZNftj0bkqVWfyPs69hqMjTiKgPEDqVEBqfTkHsuojO2SyhmFP9DKMxf
1WByc+AkCjJbAAMoNWlHyBqxIXgz+6XCHg4Cs8GpA4FMaGre3lxh1lJ6ptOlyiJp
Ib1oQAd0cN3EKTIjxqv+HHeId9M4wId9umgwe808SVRrtptGzcl1kHPMefkc0C81
SghHLjlCb+MTA9s2tqDSTuooytVDj7qbzxHQsAkY4OFxl7mYnPrZxORpNgoM6Fe4
kJHSJkCWqw7ubEFXO0dZL4kZJcIKWOqgKFhVEJSZy65Ms01bdiG9FhQL0BU0KC+Q
qmvA1pRA7GbjF49YevD4
=0IH5
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
