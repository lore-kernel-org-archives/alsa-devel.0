From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: add fallback case for jack
 detection support
Date: Thu, 4 Jan 2018 11:59:19 +0000
Message-ID: <20180104115918.GB10774@sirena.org.uk>
References: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
 <6b845088-9900-789c-1137-811321e23252@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8117070482035312099=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B40226782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 12:59:33 +0100 (CET)
In-Reply-To: <6b845088-9900-789c-1137-811321e23252@redhat.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8117070482035312099==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 11:20:38PM +0100, Hans de Goede wrote:

> > +	else if (rt5645_check_dp(&i2c->dev))
> >   		rt5645_parse_dt(rt5645, &i2c->dev);
> > +	else
> > +		rt5645->pdata = jd_mode3_platform_data;

> How about:

> 		rt5645->pdata.jd_mode = 3;

> instead and remove jd_mode3_platform_data and the 2 dmi table entries
> pointing to it ?

I'm not sure it's best practice to remove the entries that have been
explicitly added; on the other hand if the default is jd_mode = 3 then
it's not like we'll be adding any more.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOFxYACgkQJNaLcl1U
h9A6tAf/SPjOMMiwHEmGapMneL0no1vsVwMDBIaz4IATiCD2ArZJTWJH1UrZmffL
cE5sDsfRc2Y0I83d1r0ZohTEbAAVf00+HgTk8uIt2dlnXjY5eGK0BKDo4Bvwdwu1
lEM9eBlyjt+DH51XmeLXCTWsM3z0wPZnpzTunBO6q5YgOFMllF1GkNL80a1h7l0O
F9POasjseMTXjvmpOdj6cbMh2ngl+A0UtOU89qG83+vo+w/UYD4BbGkIqPuOL8c/
Z6qqW/T4G1cvDQt0V+Dhxwnz74tqIbqGf9byNcDm2CM/1eChGeFl3NZrBLJT5F+i
lCtfhuR+2vDRzSbsiQ+xKgqlj6QUrQ==
=DxMp
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

--===============8117070482035312099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8117070482035312099==--
