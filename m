From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Thu, 22 Feb 2018 11:35:48 +0000
Message-ID: <20180222113548.GF5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180221115452.GD8334@sirena.org.uk>
 <b2c6c047-eb86-a639-197e-b6aa1eae0ad5@redhat.com>
 <cc96d6a4-c8a5-1df5-8410-7671a73e6d4a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5852510534238157262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84DC02676FA
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:35:52 +0100 (CET)
In-Reply-To: <cc96d6a4-c8a5-1df5-8410-7671a73e6d4a@redhat.com>
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


--===============5852510534238157262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2018 at 12:08:29PM +0100, Hans de Goede wrote:

> So thinking more about this I think that having the codec driver only
> check device-properties and completely killing platform_data is the best
> way forward / best way to clean this up.

> Combined with either device-tree or the machine driver setting these device
> properties for now, and in the future the ACPI tables can set these properties
> directly and we can hopefully won't need to add new quirks to the machine
> driver.

The device properties thing seems reasonable enough.  I'm still not
super convinced the machine driver is the right place, but let's see the
code.  I think ideally the arch code would have a way to put all the
device property based quirks for these systems like we IIRC do for some
DT fixups.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOqxMACgkQJNaLcl1U
h9Bw0ggAhTh1XGLrr0alYNMQXOyWbWN40elITD81Zs0aE4pm4roaM2P5G2rO9Vtd
vclKO7UTg+aPQmfOR8YaQNYt44RlO2MGStl8rnqy7t0GwXx/1ehJUigdhzF9GTuT
I4ssW4X6ThvLuYi3q2Ndx+mc6OLT3CAitqtW1ZAyd4ZR10rKA1Ya2zhLEBy3p+AT
ZrnLGdppfw1AiWpBOdiLxJ2gtEEzMaRpm/y781Ypp8xRYQ3EUhbpdECZVcBaOxnT
cydIhHh5KC97/EUIYQSGYA/W4DfbflwjEPgGCDRHX1S1iL0Y3gYNhsgsPyYYCaGp
x9g3ALDSHrxfLEQL90uRjZ1hwT4+hg==
=GD40
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--

--===============5852510534238157262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5852510534238157262==--
