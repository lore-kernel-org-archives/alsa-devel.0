From: Mark Brown <broonie@kernel.org>
Subject: Re: Adjust the the codec and dai_link close sequence
Date: Thu, 26 Feb 2015 11:20:17 +0900
Message-ID: <20150226022017.GB6236@finisterre.sirena.org.uk>
References: <A63A0DC671D719488CD1A6CD8BDC16CF5ABD84382B@SC-VEXCH4.marvell.com>
 <20150224150308.GR6236@finisterre.sirena.org.uk>
 <A63A0DC671D719488CD1A6CD8BDC16CF5ABDACCC4E@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337550127444950284=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC80F261A3D
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 03:21:23 +0100 (CET)
In-Reply-To: <A63A0DC671D719488CD1A6CD8BDC16CF5ABDACCC4E@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhao Ye <zhaoy@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Qiao Zhou <zhouqiao@marvell.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0337550127444950284==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hyy7PULS0YXfQbb/"
Content-Disposition: inline


--hyy7PULS0YXfQbb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 09:03:36PM -0800, Zhao Ye wrote:
> Ok, I understood what do you mean,
> And I think we can add a cache in the codec driver.
> Let the power off operation take effect after the DAI cleanup work done.

If you're using regmap (which you should be) then this should be very
straightforward.

--hyy7PULS0YXfQbb/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oLgAAoJECTWi3JdVIfQLuIH/A60u3tcJzpAVJEnWaoVKcS3
ZvHT+Re1pxRig9QzHx590LGgPnAO4qnMnB2HBdt8glNrtL+qjM7InDyIETm+aHUY
JAEi5kjfTCPygoH598r19P2OkHXw7kfeoepH9to+rtTGr/FaL73tMX7e4y8L9uyw
+58eOwARgFn7IficUBfxGA1UO23cJfzeOLnz86idIdxUN8Kc1nrefRlRufK2KPLK
fcTWMLNS2olVOe1P27abtzSM5YNqkUXrELKRigfD/gc4llPw7PckAGogtvek/6CK
IG5KP1x/G5RKkADOyVlB1ekWHx8N+M6R8b+DN5rej46aguQDWxXFtGRCSdupowk=
=D71A
-----END PGP SIGNATURE-----

--hyy7PULS0YXfQbb/--

--===============0337550127444950284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0337550127444950284==--
