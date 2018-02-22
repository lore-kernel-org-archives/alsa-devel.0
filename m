From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Thu, 22 Feb 2018 11:32:19 +0000
Message-ID: <20180222113219.GE5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180221115452.GD8334@sirena.org.uk>
 <b2c6c047-eb86-a639-197e-b6aa1eae0ad5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5151690514131933801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 055C32676C5
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:32:24 +0100 (CET)
In-Reply-To: <b2c6c047-eb86-a639-197e-b6aa1eae0ad5@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============5151690514131933801==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 08:23:01PM +0100, Hans de Goede wrote:
> On 21-02-18 12:54, Mark Brown wrote:

> > It's not clear to me that this is a great idea.  The goal in general is
> > to keep as much of the CODEC configuration in the CODEC driver as
> > possible so we can move more towards generic machine drivers, this is
> > moving us in the opposite drection quite dramatically.

> Not really, instead of having Intel/ACPI specific quirks in the codec
> driver it moves everything over to pdata, so in a way this unifies the
> device-tree and ACPI paths.

Bear in mind that ACPI isn't x86 specific any more, and on x86 those
Intel drivers really are Intel specific rather than x86 specific - AMD
are doing their own completely different thing.  Much ACPI, so
standards, sadly :(

> Also to me it seems that the Intel specific machine driver is the
> logical place to put quirks for Intel platforms rather then poluting the
> platform-agnostic codec driver with this.

> > It is really unfortunate that ACPI based systems aren't embracing
> > standards here and using this mess of open coded quirks but it feels
> > like the way to do this is to keep the code as close as possible to well
> > designed firmware interfaces and hope that they come round.

> Both devicetree and ACPI code-paths are filling pdata and that is the
> only thing the codec driver cares about after this patch. so this is
> using a well designed interface (but a non firmware one). I can understand

It's not just platform data, it's also putting the platform data in
through a regular driver outside of the usual device model stuff.

> if you would prefer to use the functions from include/linux/property.h
> for this, but those simply do not work for ACPI platforms atm.

Yeah, they work fine with DSD which is the official ACPI way to pass
device specific data through.

> One possible solution here would be to add device-properties to the codec
> i2c-device from the machine-driver using device_add_properties() and make
> the codec driver consume those.

> This has probe-ordering issues, but those can be worked around by exporting
> something like the rt5651_apply_pdata() function from this patch and make
> the machine driver call that after it has attached the properties.

The ordering is part of the issue, yeah.  It increases fragility if we
have to wait to parse the platform data until later on in init, but only
on some systems.

> I'm not sure if this extra level of indirection buys us much though, the
> DT binding maintainers will not accept binding docs for these kind of
> kernel internal only device-properties until there are actual DT users
> of them, so for now this would mainly add a bunch of extra code for
> little gain.

I'm not aware of any such policy from the DT people, and in any case
the individual driver bindings go through subsystems so...

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOqkIACgkQJNaLcl1U
h9COJQf+MLS1js9Q+E400ZTB6PHN/4oAcxXgvFCUCrRp2K8UORhFUh+2O4NJUbVH
9X1fpfM1nXr2+5TL7VbrBL1/Ftm/QjG4ci4zkRsu5ytiy3Ak+Ze16jRXhPkU26pe
tj4ASTEhNiktSXbW/JeBg1LjGZH6KLGsqJAktgOFg0IwVA1Jladx330NUGlgkJSQ
AuJYcw/wSRhnOiqDqo4Owfv5GTXiVYA0qtecyPt9GrEewxjeNl5Y8swH1OeWmBxS
5SbhpHPkKxJaxA5t1tUMeGM25O9w4V8zdhLiJiGwtmTywMnKiZmyuV2Nhg9tRBLV
tGzfQaYl5sgVD+A55nPlgZaDOBoQ8Q==
=XSjO
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--

--===============5151690514131933801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5151690514131933801==--
