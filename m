From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/10] ASoC: rsnd: add SRC support
Date: Mon, 6 Jan 2014 15:23:44 +0000
Message-ID: <20140106152344.GX31886@sirena.org.uk>
References: <87lhzgurtc.wl%kuninori.morimoto.gx@gmail.com>
 <20131231133657.GC31886@sirena.org.uk>
 <8761pxk79s.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5817558639722124772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DC42610B7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 16:24:31 +0100 (CET)
In-Reply-To: <8761pxk79s.wl%kuninori.morimoto.gx@gmail.com>
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


--===============5817558639722124772==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpvGcHI9tIxEiLgc"
Content-Disposition: inline


--bpvGcHI9tIxEiLgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 09:29:27PM -0800, Kuninori Morimoto wrote:

> > I've applied all these but you really need to start moving this stuff
> > over to use DPCM, this is getting to be very borderline.

> Thank you for your help.
> I see, I will start moving it, but I need sample code for it.
> Who is using DPCM ?

Nobody in tree unfortunately.  The TI OMAP and Qualcomm production
kernels use it as do some of the newer Intel Haswell chips but all of
that is out of tree.  There's also the work Russell has been doing for
Kirkwood but I don't think he posted the finished version to the list
yet (he's waiting for some fixes from Liam which will hopefully come
soon).

--bpvGcHI9tIxEiLgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSysp8AAoJELSic+t+oim9geoQAIY9p6wzuKpsjeUBsknlgQow
l3ViPOQKMdHo55pJxTPd3UjCdqDSJuwTNRrZSHIQvJEClIqGWCdUGeg1d+EF5pU+
WthmLC/9Z5tmbg3cjcZ8CDKimCm5Dt6zaeaW/IJbJMxVCc3eWVmrhOAyts+v60dj
vDL70U0rg1kJ7DfJ5dCkY3h5fYd/XJP9JWlmArNS93nET39/+1vb74jd/M7bA1zp
wshyvUwnjJRtjJlffc3ECikVu89MOgzAmRNbpe9qAKkLVD6UsyVsu7ytNOGAE4yn
Ru2cwyOge6uHXQ0pUuMGFUhvJpdziZj726kw69086ewJVj6wllJ41SzL9VYc+7ya
GD4cXSdUuHuig00k65WkR01x2cAB2GoeCeImTQCTIs+jElbrwjj6F7V8Z3i8Y1PB
JikaxK6qV4vIbp3RxaiVdRq/thRiq5CKg908M7GW41uFnJCVJfbeDVImzKlyCAgt
zIn5sOtTZjVYUmenJ8Y3IgsXKanZwa2U1d6vcSkbC/mYIJuGbZT5fFmTGQg4U7lX
GQ89b5W3zSKuPR0Kr0YcMR3U7tywTPSj1oC66VTa+zutMkSp8Rjxk1fUkK7L421l
IGZ48ZAGQENBlJcJFsPDkZKZtxOLEbN55FdhzboqXcbOGCQvJIwCB5U909SNIxT4
eLiLt4YSU2+r41tKGx8v
=KrJG
-----END PGP SIGNATURE-----

--bpvGcHI9tIxEiLgc--

--===============5817558639722124772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5817558639722124772==--
