From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: rt5651: Simplify
	set_bias_level()
Date: Thu, 22 Feb 2018 11:12:54 +0000
Message-ID: <20180222111254.GC5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-4-hdegoede@redhat.com>
 <20180221114328.GC8334@sirena.org.uk>
 <92dc88f0-c928-3c15-3295-b77a5dedbd58@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6858929032879199629=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA57A2676C6
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:12:59 +0100 (CET)
In-Reply-To: <92dc88f0-c928-3c15-3295-b77a5dedbd58@redhat.com>
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


--===============6858929032879199629==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 09:11:34PM +0100, Hans de Goede wrote:
> On 21-02-18 12:43, Mark Brown wrote:
> > On Tue, Feb 20, 2018 at 11:15:04PM +0100, Hans de Goede wrote:
> > > There is no need to set the LDO voltage to 1.2 volt each time we enter
> > > standby, instead always leave it 1.2 volt on BIAS_OFF. Note we do a
> > > snd_soc_codec_force_bias_level(BIAS_OFF) on probe, so this will configure
> > > it correctly right from the start.

> > That force on probe sounds like a problem...  if this is being done once
> > at startup it should be done in the probe function, not in the bias
> > level configuration.

> This is more like "we do a snd_soc_codec_force_bias_level(BIAS_OFF)
> on probe anyways and that already sets the level to 1.2 volt, so
> we don't need to do this explicitly at probe time".

What I'm saying is that if the code is written such that you need to do
that _force_bias_level() then it's not very idiomatic which is a bit
worrying - it might be safer to reorganize the code so that this isn't
required any more.

> > Also, are you sure this is a good fix?  If the bias voltage is being
> > configured all the time does that perhaps indicate that for better
> > performance or something it should have been being set to some other
> > voltage when the device is in standby?

> We switch the LDO off when in the bias level is BIAS_OFF and on
> at 1.2 volt when in standby or higher. Before this commit we would

OK.

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOpbUACgkQJNaLcl1U
h9BiBQf7BTgIWFHQ6p8IyhWQaOmFyIThcOnEb10d/rKydSx7Jp/Z2zSqc82aMsIm
3Xe7ceDWy9w0cJhNz5uSrv5iPs2aJhB/K9t2+bx5pAr1dNm9DPYJWbDSTf/lsfeo
1fO+xopK5GUmWefuPryyGoJA+7EwLMqJy6Y4cnwF3X4Wy2hFR28nt6QCe6H9e0JW
GXiOI/dYgpQSoc9NyTUwMwgYHV1hQb8Nud+VUKk0qYw6zHpa9w1FClrLZCRj/6OW
sbAt+zk4LW9HxFFvmc4Vk/U54BMoVYtjwrwWMtovXag9pV4XHXnTvHtKAzZ5o1gN
xvrtSU4S0HXRRbfUq8WQ7b26igXHLw==
=OhFs
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

--===============6858929032879199629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6858929032879199629==--
