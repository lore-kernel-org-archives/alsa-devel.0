From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Fri, 13 Mar 2015 12:02:05 +0530
Message-ID: <20150313063205.GB32000@intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150312195420.GB28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6960326152419709308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C0EE26055F
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 07:35:42 +0100 (CET)
In-Reply-To: <20150312195420.GB28806@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, mengdong.lin@intel.com, jarkko.nikula@intel.com, yao.jin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6960326152419709308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 07:54:20PM +0000, Mark Brown wrote:
> On Thu, Mar 12, 2015 at 10:31:55PM +0800, Jie Yang wrote:
> > In order to prepare for the upstreaming of Skylake drivers and to
> > allow reuse of code between different Intel audio DSP products,
> > this patch series restructures the Intel directory as follows:
>=20
> This is all fine by me - I'd just like to see an ack before we do this
> from the other Intel people to make sure they're not going to get
> surprised, and also make sure that any in flight patches (particularly
> bug fixes) get merged before the rename since this will make it easier
> to apply things. Indeed, do we have an ETA for the Skylake code?  If
Am working on it :) That will take time IMO, the HDA things are tricky here
and will get done first followed by ASoC core bits and then finally driver.

> it's not due before the merge window then it might be best to apply
> these (or changes like them) at the very end of this development cycle. =
=20

I think that is a good suggestion, we can send this when merge wondow closes
so no issue with in flght code

--=20
~Vinod

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVAoRlAAoJEHwUBw8lI4NH86cP/j3TTVGCfCoNhpkFPDSZrJjL
rwmp7GtzwDZm3+AO465B4ufHOwjGUdu7uBpKJmyPPONQNCCFbeETtMk/KLqpH6r5
cO5LW9QhPe5moqxqLOoBy536hW6+Of16F+OYlzBoUXkRgTqJRKAdCw7u5TsrOPa3
O3y9zX//HxuH0Y1Aj98tvJR/e+W1IrsGDQCvwFFL6JepfuSZj1n7pxU187ooGKz0
16qfBZJmw3gwr2hobNBsUeK9J5HrreyOfIzZy6LcmML21PaKX7iKp8PKwr/lRhD5
qdGIj6eQ8YioyVswiIhgohc3zrhFkPRZGNcDdqAMvc6qOkXecr6PWbzfK3Tvc4nF
3citFRPl3dL+R3prrAFcE3O8RCNnvyPksCsL8wr0cLDMQeHbFBiq6EcST/XM94Vo
/vHOSSahrmr5CuHE7xUgMM5Wm9YvwzMlqUyvq7Kk/kA229VdBYNJD6y4kITRDKFS
IfOXyb3J8B5HNpkg6OuJQ+vm0yhkJDyM1Zx2iVDmJ4SdRpftgCPI+8LmtgNe1w4Q
bM4ynLU+L/ouIWhVwVjmdzj7x8PM8rdh8bzqLMA1QIfWRr2oWBmhs/gGdbNmBlBL
sl7dnyA9/WKYNwVb2T0pGMX4f1RwbH/8XVjfKMG5kyyL9hMaujs2s/TiPnhpap9D
orTQqpJQHCFXwnhiLd87
=foDT
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============6960326152419709308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6960326152419709308==--
