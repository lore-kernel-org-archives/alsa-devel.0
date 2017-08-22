From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Tue, 22 Aug 2017 12:38:32 +0100
Message-ID: <20170822113832.6m62m6mwyepl4qrw@sirena.org.uk>
References: <CABCoZhATXrkyxxgvVW5jAiZ4YYc600RQ55G_rFO4xN850cpM7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7029824846589770644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C00D02675B6
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:38:36 +0200 (CEST)
In-Reply-To: <CABCoZhATXrkyxxgvVW5jAiZ4YYc600RQ55G_rFO4xN850cpM7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7029824846589770644==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zbdp57zacwxbpiq"
Content-Disposition: inline


--6zbdp57zacwxbpiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2017 at 11:36:24AM -0700, anish kumar wrote:

> Currently in codec to codec dai link if there are multiple params defined then
> dapm can use created kcontrol to decide which param to apply at runtime.

> However, in case there is only single param configuration then there is no
> point in creating the kcontrol (this is currently happening) and also there
> is no point in allocating memory for kcontrol.

> In the snd_soc_dapm_new_pcm function, there is memory allocation happening
> for kcontrol which is later used or not used based on num_param. It is better
> to not allocate memory when there is only a single configuration. This change
> is to remedy that anomaly and also it remove unnecessary checks.

It's really hard to relate this to the change, like I say it's quite a
big change and the details of the change aren't clearly explained.
Perhaps if it was split up so that there was one patch mostly moving
code and another stripping out the checks that might help.

Part of this is that the amount of memory that is being saved is going
to be fairly small so the risk of a complicated review is higher.

--6zbdp57zacwxbpiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcF7cACgkQJNaLcl1U
h9BecQf/SA9jHABDe24mx9jGadiT6VXPhfah6TO0wzGFVGYesS03XwxcrEm0gOFS
YYJFdOsBMTO/ePEATQTdoqGY1B4jz9fbzEpV8Kac5LhYfS4iSpcqh9I/o8MDwOBG
rbU3ucO922fTUkGqlHqtUzxzz4fjedeqh81/kYI4YCNWEc2kGq0LEIXOuaY+1hjS
LdgvqPtSd7bpNc+Rq2E8dEozz5Ca2ceCT25A610iqcGBYj337qc28WdFH7lHDemd
u8yDQBTivL0a2vQ+G8XbW9kCs+OdSwgeutuNM+OD9Or7Xwfx6/ORxrb+QsfpaWWx
oIVDzMWB+4dq8VAbHgo1qVjVx5D91w==
=L4N/
-----END PGP SIGNATURE-----

--6zbdp57zacwxbpiq--

--===============7029824846589770644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7029824846589770644==--
