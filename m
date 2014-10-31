From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Fri, 31 Oct 2014 11:53:30 +0000
Message-ID: <20141031115330.GN18557@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
 <20141029225659.GS18557@sirena.org.uk>
 <87r3xqxf1z.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5811067554027761090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 012FD260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 12:54:01 +0100 (CET)
In-Reply-To: <87r3xqxf1z.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5811067554027761090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xc/daCAYeCLA4DS1"
Content-Disposition: inline


--Xc/daCAYeCLA4DS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 11:11:23PM -0700, Kuninori Morimoto wrote:
> > > OK, I can be a 1st guy :)
> > > The HW setting is like below

> > >     value: mean
> > >     00000: 128 dB/1 step

> > > Current "DVC Out Ramp Period" wants to have direct value of register.
> > > But, upstream want to have time like this ?

> > Yes, please - much easier for users.

> I tried to use "time" for Volume Ramp, but it seems difficult.

No, just quote it as you've listed it above rather than with the
absolute time.

--Xc/daCAYeCLA4DS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU3g6AAoJECTWi3JdVIfQmfwIAIIPrMBFk8nT4hBuabCPbtcY
YazcTNaUe6yX/iH+j3demcb4zgMxF3+YzEBEqvBIh+jvzQTdoJegn9udLP1egUK/
IDjCLQ6cqel2rRi+sdwz35ZmMoei6y1BnEgQ4yYaw4CcuslgZn+f0k3LS9TQIR6m
L3oefq+40s24P3jZcuJSC3a2OiyyWgPm/cucoKgWiPtRMsiC39iXwgujLIi7OfCe
rSuHwXfA8RzZ4eIxvlbcUPAGwSf0ZWFom/It/1JbC7Wf7squj5yeIr9gYjeNE2uU
V4F5YwNj1JwwxP8qhFTD615UVo33+5Ixzvjt6moD0SeXKTRDpMEF6zqQPTt3XVk=
=Xqqn
-----END PGP SIGNATURE-----

--Xc/daCAYeCLA4DS1--

--===============5811067554027761090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5811067554027761090==--
