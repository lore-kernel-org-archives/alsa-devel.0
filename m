From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 122/187] ASoC: twl4030: replace codec to
 component
Date: Thu, 18 Jan 2018 17:09:44 +0000
Message-ID: <20180118170944.GC6747@sirena.org.uk>
References: <87bmhzevk9.wl%kuninori.morimoto.gx@renesas.com>
 <87fu7b7sz4.wl%kuninori.morimoto.gx@renesas.com>
 <5a4a4358-75c3-886b-bb6d-d9cbfecfca4b@ti.com>
 <87tvvkkp2q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8991887513617687875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 81508266A74
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 18:09:49 +0100 (CET)
In-Reply-To: <87tvvkkp2q.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============8991887513617687875==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2018 at 12:07:57AM +0000, Kuninori Morimoto wrote:

> > The pmdown_time was 5000 by default (see soc-core.c).
> > Ah, in snd_soc_component_driver the pmdown_timme is _not_ pmdown_time,
> > but use_pmdown_time boolean...

> Ahh, naming... hmm.. Yes, indeed.
> Mark, I know you still not yet accepting these.
> We can have 2nd chance to name it ?

Yes, no problem with changes.  This feels like we might want to add a
pmdown_time in the component as well.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpg1NcACgkQJNaLcl1U
h9D7xwf+LkOPzoNFhskyXi3mXY4+u9JNKEkC1nXwXmY4QoUgUuzKZpeiW+wsrDLQ
tbsfvCc35GD8HCYR2Q3FvXVg7mKUSyC93dLwCUHXjio2mBh9lrpGCqByBYJjj2kG
4d1XNsdrtwWc0FEnEL7TGleG4CPMNBnlutJv+vnSUVCle8nHmVagALBlw8LBOcdr
K9oT/gzdCIY1hPoPHpWfhmL/8jzuZccr9KeyyS3egoS14rJIWSvu+DnHDY9R+eUA
Dd/XzmRcVHCSx+dElusPcDNLxh6NHgjDOPsy1LG6FnTwgAocUc9LpLesWIYgfHdt
XFZLFYnS+lDqoBEh0vlaixdlJV+UJg==
=Jhoj
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

--===============8991887513617687875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8991887513617687875==--
