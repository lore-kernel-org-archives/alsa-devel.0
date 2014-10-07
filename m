From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: core: fix use after free in
 snd_soc_remove_platform()
Date: Tue, 7 Oct 2014 13:12:45 +0100
Message-ID: <20141007121245.GA4609@sirena.org.uk>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
 <1412682085-5217-2-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897290600440814761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2721B26045E
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:13:08 +0200 (CEST)
In-Reply-To: <1412682085-5217-2-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0897290600440814761==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkJ987n7uXEPtlXE"
Content-Disposition: inline


--vkJ987n7uXEPtlXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 01:41:23PM +0200, Daniel Mack wrote:
> Coverity spotted an use-after-free condition in snd_soc_remove_platform().
> Fix this by moving snd_soc_component_cleanup() after the debug print
> statement which uses the component's string.

Applied, thanks.

--vkJ987n7uXEPtlXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9i9AAoJECTWi3JdVIfQzO0H/1n7MpzIlGVg1Pz7Ee3Z6L87
RzrC+N2sSFB//rpKoCL7/bS3bDzO2o0RNFFdqwRLvbCTLxP0w6hbSnAXsNu0BoON
PrROHTrl6h+QX7bQxWNSjfMD0J49diCyJ2sR7cXPBlgaiRErYvkrqlGuGe77RP8j
HNvS3/sEv+F4/YChEQ3QHcvbM+cScv1xaX9xtXylq48tfGDl5mz8He5e3CgCIUeW
wAfdo7C3NlwYxfz6xILFJPzXBWcPpQ5lfUjN6+mb9SHiBGtsIgGuRM0u6i/2vjBH
FjZbrzEkcMX5PiYlKPUmC+9ae1QrvxEgAdDl0cwBk6x+3WDL5fpyWImCG1LH+VM=
=Pzt+
-----END PGP SIGNATURE-----

--vkJ987n7uXEPtlXE--

--===============0897290600440814761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897290600440814761==--
