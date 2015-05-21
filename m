From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 21 May 2015 03:24:41 +0200
Message-ID: <6154326.X9FC8ZVDIy@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <3695901.X9t2lWziuY@vostro.rjw.lan> <20150518044711.GA3401@air.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2273762.08MRHt2xB8"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150518044711.GA3401@air.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--nextPart2273762.08MRHt2xB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, May 18, 2015 06:47:11 AM Dominik Brodowski wrote:
> On Mon, May 18, 2015 at 03:01:32AM +0200, Rafael J. Wysocki wrote:
> > On Sunday, May 17, 2015 07:41:44 PM Dominik Brodowski wrote:
> > > On Thu, May 14, 2015 at 11:55:33 PM Rafael J. Wysocki wrote:
> > > > On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> > > > > So the only value that would really make sense here is 5.
> > >=20
> > > > Overall, what about the appended patch instead of your [2-3/4] =
(modulo the
> > > > new command line parameter description which is missing here AT=
M)?
> > >=20
> > > Well, this approach works as well -- limiting it to an override f=
or just 5
> > > seems reasonable; expanding blacklist.c to also cover this case (=
even though
> > > it's not a blacklisting per se) isn't worth any discussion.
> > >=20
> > > Nonetheless, a few specifics:
> > >=20
> > > > +config ACPI_REV_OVERRIDE_POSSIBLE
> > >=20
> > > Why should that be a config option at all? The code savings shoul=
d be
> > > really, really tiny;
> >=20
> > The idea is not about the code savings, but about having a simple w=
ay to disable
> > the whole thing entirely at one point.
> >=20
> > All of the workarounds under this option *including* the command li=
ne switch
> > should be temporary.
>=20
> Hopefully, yes. But I am not convinced about that yet (see below).
>=20
> > > and especially in the beginning we might see a few
> > > machines where testing the override might seem to be a good idea.=
 So I'd
> > > favour having the command line optional, and then only specific q=
uirks
> > > behind a config option: For the Dell XPS 13 it makes sense to dis=
able the
> > > quirk if userspace can manage i2s sound; for other systems, there=
 may not be
> > > such hope. And as this is a machine-specific decision, I fear tha=
t we have
> > > to do CONFIG options for each and every such DMI entry.
> >=20
> > I'm not sure if we need a config option for Dell in particular.  We=
 can simply
> > drop the quirk when it is not necessary any more.
>=20
> The quirk for the Dell XPS 13 (2015), yes. Once userspace catches up =
(which
> may take _years_). But Matthew was mentioning that "[t]he Inspiron 74=
37
> queries _REV and uses it to modify its EC behaviour, and apparently b=
reaks
> on Linux without that." If that is indeed the case, we will need a qu=
irk
> for that Inspiron for much, much longer than for the Dell XPS 13 (201=
5).
>=20
> Therefore, I see a need to distinguish the quirk for the Dell XPS 13 =
(2015),
> the quirk for the Inspiron 7437 and potential quirks for other system=
s: Some
> may depend on _sound_ userspace being up to date (XPS), some may depe=
nd on
> _other_ parts of userspace being up to date, and some may be needed f=
or
> as long as these systems exist (Inspiron 7437?). And if the userspace=
 for
> the XPS is up to date, the quirk for that particular issue may not be=
 needed
> any more, while other quirks (such as potentially the one for the 743=
7) may
> still be needed -- that is why I see a need for different CONFIG opti=
ons.

Which doesn't explain why we need a config option per quirk.  To me, su=
ch config
options don't add any value, because (a) everyone will set them anyway =
and (b)
removing the quirks from the source is trivial if needed.

> > > > +#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
> > > > +static bool acpi_rev_override;
> > > > +
> > > > +int __init acpi_rev_override_setup(char *str)
> > > > +{
> > > > +=09acpi_rev_override =3D true;
> > > > +=09return 1;
> > > > +}
> > > > +__setup("acpi_rev_override", acpi_rev_override_setup);
> > > > +#else
> > > > +#define acpi_rev_override=09false
> > > > +#endif
> > >=20
> > > Why __setup, and not module_param? Should mean a smaller diffstat=
...
> >=20
> > Because it is consistent with the other __setup things done in this=
 file
> > (and none of them is a module_param, mind you).
>=20
> module_param's aren't unusual in drivers/acpi/* and have substantial
> advantages IMO, but I also see the issue of consistency -- so if you =
really
> do prefer __setup, I'll use that approach in the next version of the =
patch.

In this file I prefer __setup.

> > > +config ACPI_REV_OVERRIDE_DELL_XPS_13_2015
> >=20
> > I'm still not seeing the point and this is just !@#$%^&*()_+ ugly.
>=20
> I _know_ it's ugly. But this whole suggested change of _REV behavior =
after
> 3+ years is ugly, and its fallout may very well be considerably large=
r than
> is known at the moment: It all depends on whether there are other pla=
tforms
> out there which need such quirks, and whether these quirks are needed=
 for
> different timeframes than the quirk for the Dell XPS 13 (2015).

It was done in response to active abuse and things would have broken an=
yway
after adding ACPI 6 support to ACPICA (if the spec hadn't changed the
interpretation of _REV return values).


=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart2273762.08MRHt2xB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJVXTPiAAoJEILEb/54YlRx4uAP/jy8Fg1LmWXpiugwwkVvrpc9
p/C1SLSHm/WtNYOHtzbZ8z3eTUMD2hryUL4XnautfK5p1j1eG8HX3mEdbGSpdIwL
JBg6jquArGeu3761qgXkWoIveXS4Wz4i6VBsmDehbIG5G1q+tx2h9kZ7njLMAN+X
xvqL2V8f8SxfC3WqwXh/iKUOKbscdHo3TngsNiDaUylppqkStTU9D8QozEq/NYEM
UGbXoqTkTyGbCv+XTRkgQXW3dF158ZGhAbV0IBjmornuTEdnFUNQfIT3wPIV1n90
nnU+TiRT6fnNd9gcWM1KIK/wMjNMRTiV9zAWALDz6pHmpde87BB9/8km6YzM4GMn
lrZLtWjIx3nEVLEdpSDVs4agrMlTHiv58IduBWLwkecx2LiduXvbbRfboRHRD0gc
F7fgJLvmsLrGpbdhPXKzTb/6Jb6JGFKE7FHArKvmBXU27aKJEtyO/oOXiv5YKNsu
8JeqpIwFeXVdV+1hht7BfzoAPdBLCoLK7o8j3/Xt1ueAky8EJXh92x/9y3oO26JU
ugBVvgQB5+VXbCVQR5141oW8R/rRPc5MBnFZ4Io+tL0fNk+/2StcBKAvDYxC4uEF
sx9/VIDRf5iIF9+9vI6a/nJHH/MisCuEPCspj6xqLgJVIDbex0cMgRxNurUPx+U/
y3oqEFZNAB2Rg8jdndOa
=iwLP
-----END PGP SIGNATURE-----

--nextPart2273762.08MRHt2xB8--

