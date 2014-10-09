From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Fri, 10 Oct 2014 00:10:42 +0100
Message-ID: <20141009231042.GC18557@sirena.org.uk>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1687836642255353530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F3D260434
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 01:10:58 +0200 (CEST)
In-Reply-To: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: oder_chiou@realtek.com, tiwai@suse.de, alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============1687836642255353530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2014 at 03:11:27PM -0700, Dylan Reid wrote:
> The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
> units.  Switch to use TLV_DB_MINMAX as this allows the minimum to be
> off by only 0.005dB.  This is an improvement from the ~500dB is was
> misreported by before.

The usual thing to do with these is just to halve the resolution of the
control by ignoring the low bit so that you get exact values, though for
this device that does result in a relatively large step (step sizes like
0.125dB are more common).  I dunno, doesn't make much difference either
way from my point of view.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNxXxAAoJECTWi3JdVIfQXuQH/1RZSNrXbnM35kb4B1BlmCL1
DiGwqehwS4v7PPfs8BaAVHxUJCsED/t+eU2Ege5bqCP8smbUAvvpHG2GXSLGx3Ps
i28BrqiAlcftNo5tUuzDO2md16fKV1I/r2Azis2ztsPswD7o3UAtxzICwOaXRUb7
CoCAb5EalLQ2MMjZmlewN41l8j/Qnp8z9K96r2N+u6Ja+BZQ5I9J7Byzu8O0v0Ri
mhYiha6HhBivC17zbQsfImkYRWJnNbrYvXomTOl8Mh/04m45vczsaYwcyBityseq
i3EccmWymMO8Y/Xi2sJaXw1jeFSKVG9F1Y5j+94VSe8dAQs1/vF1Vw9MoM2B4G4=
=HTxh
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

--===============1687836642255353530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1687836642255353530==--
