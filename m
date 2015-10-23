From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: AMD: add AMD ASoC ACP-I2S driver
Date: Sat, 24 Oct 2015 06:18:05 +0900
Message-ID: <20151023211805.GN29919@sirena.org.uk>
References: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
 <20151022161415.GU8232@sirena.org.uk>
 <CANv6ZMY_8MzZK0StdgAnzN7EqZVJ3tMz88pKACb3sGKXmRTtXQ@mail.gmail.com>
 <20151023193152.GL29919@sirena.org.uk>
 <CANv6ZMbv-Pe7HFzv4BPX00qPrfMpMxD440hTV2ptfVxC2tK8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1550597502=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CANv6ZMbv-Pe7HFzv4BPX00qPrfMpMxD440hTV2ptfVxC2tK8Tw@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Cc: alsa-devel@alsa-project.org, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1550597502==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2015 at 02:21:04AM +0530, maruthi srinivas wrote:
> On Sat, Oct 24, 2015 at 1:01 AM, Mark Brown <broonie@kernel.org> wrote:

> >> >> +static void acp_turnoff_sram_banks(void __iomem *acp_mmio)
> >> >> +{
> >> >> +     /* Bank 0 : used for DMA descriptors
> >> >> +      * Bank 1 to 4 : used for playback
> >> >> +      * Bank 5 to 8 : used for capture

> >> SRAM banks are part of ACP IP. With ACP's runtime PM handling, all blocks
> >> within ACP IP can be powered-off and on.

> > So why can't that cope with these banks then?

> Maybe Iam not clear before. I mean that memory banks which wont be needed
> at all are turned off forever. Using runtime PM, when complete ACP IP gets
> powered-off all the banks(including the ones used for play/capture) within IP
> are turned off. When IP is runtime resumed, though all banks gets turned on,
> the unused banks are turned off again. With this, Iam trying to achieve
> runtime management.

So the initialisation that's done to power off the unused memory banks
somehow gets preserved when the block is powered off during runtime
power management?  It's really not clear, this looks like it's only
called once on init.

Obviously it's also less power efficient than it could be too since it's
going to (so far as I can tell) keep the playback and capture areas
powered up even when only one is in use.

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKqQMAAoJECTWi3JdVIfQwicH+gJ/1icyTPWOJUvU8Topiqmk
D+h3uqV1xBsb3jfv6G0aiFVIM7EN7tHgA3/39EGQLjI2dyedIcLorD5Mqnctpp/T
hqEXmX+V1pCto6cWvcXGRTR1Jfn72g5FQYgryFKp31sPOjkUOouTWDoXNNrz5t9X
bYUMzJogPxzvIg6u+kcZ3wfatlSinm289WpzL/7s/3imPfc92zbRLy5d9LMg0k8g
Y+EfMbxwE4CwCt0/fOL9hMeDQU54/0VdEwyGiHF4HY0q5XtuwJhOIffZGQ05Alo3
YzABIXYwOhAWmf+9+mbHCCivwP+3zgIB+z3Gh/4VTVzc3uMBSrj2uuG26E8bdcM=
=l6d6
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--

--===============1550597502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1550597502==--
