From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Fri, 2 Mar 2018 12:18:01 +0000
Message-ID: <20180302121801.GE6255@sirena.org.uk>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
 <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
 <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3052902658727071918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A47BD267377
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 13:18:14 +0100 (CET)
In-Reply-To: <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3052902658727071918==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 10:32:25AM +0100, Hans de Goede wrote:
> On 01-03-18 23:35, Hans de Goede wrote:

> > It is not _that_ fragile, but I agree that it would be good to add
> > a comment about not moving the property-parsing to the codec driver.

> So one other solution which comes to mind here is to move the
> snd_soc_card_jack_new() call into the codec driver's
> rt5651_apply_properties() function (conditional on a jack src being
> set in the properties).

> This would make the machine driver code look like this:
>=20
> 	props[cnt++] =3D PROPERTY_ENTRY_...
> 	props[cnt++] =3D PROPERTY_ENTRY_...
> 	props[cnt++] =3D PROPERTY_ENTRY_...
> 	props[cnt++] =3D PROPERTY_ENTRY_...

> 	ret =3D device_add_properties(codec->dev, props);
> 	if (ret)
> 		return ret;

> 	ret =3D rt5651_apply_properties(codec);
> 	if (ret)
> 		return ret;

> Which makes the ordering really clear without needing any
> comments.

It's still unusual to have something outside the driver trigger property
parsing, though the EXPORT_SYMBOL_GPL() would make that apparent.

> This will also make the jack-detect device-properties work with
> devicetree platforms without any changes to their platform code,
> which currently is not the case since the non Intel platform-code
> does not call snd_soc_component_set_jack().

What makes you claim that?  Any board with jack detection wired up will
call that function.  Not all boards have that configured of course but
there's absolutely nothing Intel specific about that interface.

> Thinking more about this I believe that doing the
> snd_soc_card_jack_new() call inside the codec driver based on
> device-properties is a better solution then doing it in the
> machine driver.

No, that's really not a good idea.  Any jacks in the system are part of
the system specific wiring, they're not something that's intrinsic to
the CODEC.  Even with fairly basic setups you've got options like having
a headset jack or separate microphone and headphone jacks.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZQPgACgkQJNaLcl1U
h9B5Ggf/bI/MBrSTefhM8ofJLQwap4HcDsFcWjiFQVxs2JHBQWu34KUCmHc0U348
XYks6DuCMjFs0CprzcAv8w58ANBQaN8H0b+IZ2+ZE9efvZRvj+ic/vOOMz0MMqv7
k2hdeRAi5ntbh2++sYBCkacw5IZTWDJg0u6pDSpLQC+SqmWvzSU01wzclw6NIJrD
jxT6rHZ1L7bN3+mRuT5IwemE5qyBAcPCUatfgAgHSD8zVcvGL0cH4aokLz86czXG
uN1/ATrJ726YSFYtqE9PPO/9P2UmKQvMOHn2RzktP3mTNHAzJog/AVh8iAP6SCRD
UnJKrkYjhjWQxFHmb8YrWqHr+K6XDg==
=sLle
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

--===============3052902658727071918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3052902658727071918==--
