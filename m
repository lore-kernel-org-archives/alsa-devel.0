From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement
 symmetric_channels and symmetric_samplebits
Date: Tue, 3 Dec 2013 14:58:33 +0000
Message-ID: <20131203145833.GV27568@sirena.org.uk>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4242285351045859128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A083265211
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 15:58:41 +0100 (CET)
In-Reply-To: <1386067087-12243-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============4242285351045859128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bVsR27XclOPPgt1U"
Content-Disposition: inline


--bVsR27XclOPPgt1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 06:38:07PM +0800, Nicolin Chen wrote:
> Since we introduced symmetric_channels and symmetric_samplebits, we implement
> these two features to fsl_ssi so as to drop some no-more-needed code and make
> the driver neat and clean.

Applied, thanks.

--bVsR27XclOPPgt1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfGVAAoJELSic+t+oim9D/kP+gK6ydmP765EsSJAvSrl+oFr
qDaUtCcDzJJ+f/8DtyUp2ZIUE6f4PdafqMZW4R8cLx3t7dkDQtty84ObwvlAqdcN
WHNbhglXvm8OmcNwo7iCu7Sf7WpKMHA3adDnPCXdMuzcfpkRh06V8idNJO5s1xtn
yykJDnOtZ9GstKN6ytChh8re4jLyPHTQn59G/vkuOFTc2rx1VtrEmz9Hito8VLew
PGFj9H8VjKEyx5amPmIdG4PvEVn+I8dGQt2G2Ye6jxyzgMzXB5XxfCLvhRnfuGOy
qeA/+aozKUQLbP7ZYcdQOS0WsDVD9bibZzKgCq2qhS/l4kpJig5FRifYaA/44uQg
dAM7eDokNOpLYsFWg+t9yXEW6C5F+svLuTrfaWBc3Bwc9c2gUWNT+S3TuN0pdtgC
D2LhIKJgCOAP6BHGLIJ0sMErhsozEn+yXV0ylv91J90L5YHgvsofBEpuV6pWmfBb
qhyGOi9lWQ72+aeIWJSYOJd4KgTisUuMzjKKtmwaB924KOa0YDlDXFM72NJiWMKD
Q9GSNa3xRcBFMWilspZHS22If2LchLfHg8N2X7tNgdVJiLY+3/yq1caEW+n5kljZ
tEpAmxPkyEp1jilc3PG+8kc9nOqDitQ1iI3wLZ/8bKOGnCSdcudNb+klDtebGkiR
phISjL2pMu/zSMFgIq0b
=ig8r
-----END PGP SIGNATURE-----

--bVsR27XclOPPgt1U--

--===============4242285351045859128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4242285351045859128==--
