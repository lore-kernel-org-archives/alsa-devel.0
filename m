From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: soc-pcm: fix dpcm_path_get error
	handling
Date: Wed, 10 Sep 2014 11:33:33 +0100
Message-ID: <20140910103333.GS2601@sirena.org.uk>
References: <1410342847-19295-1-git-send-email-zhouqiao@marvell.com>
 <1410342847-19295-2-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0229734744106715064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A9312619E3
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:34:03 +0200 (CEST)
In-Reply-To: <1410342847-19295-2-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0229734744106715064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vM+jrqt/DYO3gep+"
Content-Disposition: inline


--vM+jrqt/DYO3gep+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 05:54:07PM +0800, Qiao Zhou wrote:
> dpcm_path_get may return -ENOMEM when allocating memory for list
> fails. We should not keep processing path or start up dpcm dai in
> this case.

Applied, thanks.  Please don't send cover letters for single patches -
it's just more mail.  If anything needs saying it should either go in
the changelog or after the ---.

--vM+jrqt/DYO3gep+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUECj8AAoJECTWi3JdVIfQ7bwH/ieGz8q2HrkYxQkwr1MLHhW6
EwR7bCybSbU549En3pdcaYMUu9sSN24p/ODHNfQl4oo6pZezvyN+ceJ7lI3uQXWq
VdcB+5iqqxIdFHWRxtVHRGEU4PlmEYknX0xgVoQ5JBHgEmbE5L3NH8V8hSeY/O3W
uDjpClC1uNUC1YoNbUmUWrRuUu3lUvkufWBzzAXDLcu8MECyZv26UiqA+m8KCtqg
1MDXv1qf9qDh31LFxDlS1zNdQyzI6HMfN7te85NxTR2lJFTz8UE21U9IFQghVrj2
4CibYUeCs2eLAHr8n1Fl56+DvUOxDnoi73jrPLdmBG2u9q9IJLi8oO8yk0t7c04=
=Pg8F
-----END PGP SIGNATURE-----

--vM+jrqt/DYO3gep+--

--===============0229734744106715064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0229734744106715064==--
