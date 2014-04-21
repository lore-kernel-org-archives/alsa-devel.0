From: Mark Brown <broonie@kernel.org>
Subject: Re: How to create a proc entry for an ASoc codec?
Date: Mon, 21 Apr 2014 23:42:10 +0100
Message-ID: <20140421224210.GJ12304@sirena.org.uk>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B3DB083@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4076378610130448518=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 868902608B7
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 00:42:22 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B3DB083@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4076378610130448518==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qe7hL+wfWyneuNoc"
Content-Disposition: inline


--Qe7hL+wfWyneuNoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 09:16:03AM +0000, Lin, Mengdong wrote:

> How to create a proc entry for an ASoc codec under the sound card?

> We hope to create an proc entry for an I2S codec under /proc/asound/cardx, to debug the codec status at runtime.

> So after the machine driver calls snd_soc_register_card(&soc_card), I calls snd_card_proc_new(soc_card .snd_card, ....)
> But no codec entry is created although dmesg shows this function succeeds.

> How ASoC creates the proc entries such as 'id' for the sound card?

In addition to what Liam said it's worth mentioning that due to the
deprecation of /proc most of the ASoC diagnostics are exposed via
debugfs (and for things using regmap that also has debugfs data too) -
you're likely to get much more useful information that way.

--Qe7hL+wfWyneuNoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVZ6/AAoJELSic+t+oim9KdEP/iRZ/VEBDJdzsCm9m/5gsaTo
sUcGtkIDhfXcdZ4xoQitGNp7tnCDDGPlvQouOGfPn5j+ahzFfuVIUvoKchOF8hgA
NBbG4a+CqJlGBLUUvHyYsR6krC3WrPSXEX0Pytoc6gItDc+ofnLt/xMOZF9Vc/A6
Q3OCS2a+2B2trDyrrjmRJGra4ybzqovfBKTVIxB6nni8/Z4XyIr9GyMByEcPj/nK
RAxqdNqAhYu96Qt4lJFmmVBZKQ0CD7A/xe/38D4xTMSx3KppLt/y2NDPF4tnlAIX
Do1eF4IBO+fv58pA2qHYB9E7CcotRcx1u8ZJvQI5IFt83KnULa/KT1o3fdVqG1XY
nbKohceyLrqcFG6p/rm93hZlZ5N/tQ6QVenK+6zz+mxKZe3ZWzmgOf7Ubz0iu5Ox
bund02cj7C0AeOSGiVyK0xuZ8Ld5k71ad2yJMw/fZfzK7u6ud6bZxGXwUO7/efPd
FXixUKZbA9V/ycgeedfm9tyCS4pzzXNITIKmby0pnrPrQv4xUs+tFlsZkuMRqfaM
1D4568uCcjEkYdDF/8PKsCJxa4X4F0Fj+fGMZhipwOFjzw07gme3yJdcJ8hI7IBC
j729ggM5HvKbz/QL5GoBXLkqaP7wy65qxNj3aKuuOcwuQHSQYruQXlaMJOeh31ss
tvM202zkTldq+mIad/nS
=UBG+
-----END PGP SIGNATURE-----

--Qe7hL+wfWyneuNoc--

--===============4076378610130448518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4076378610130448518==--
