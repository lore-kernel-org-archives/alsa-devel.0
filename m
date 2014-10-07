From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: 88pm860x-codec: Fix possibly
 missing string termination
Date: Tue, 7 Oct 2014 13:13:37 +0100
Message-ID: <20141007121337.GC4609@sirena.org.uk>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
 <1412682085-5217-4-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5210714798350818146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D10260452
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:13:49 +0200 (CEST)
In-Reply-To: <1412682085-5217-4-git-send-email-daniel@zonque.org>
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


--===============5210714798350818146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jSXJDi5r/aeatSyx"
Content-Disposition: inline


--jSXJDi5r/aeatSyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 01:41:25PM +0200, Daniel Mack wrote:
> Coverity spotted an issue with strncpy() in pm860x_codec_probe()
> which does not take the \0 termination byte into account. Fix this
> by making the buffers one byte larger so the can really accommodate
> MAX_NAME_LEN bytes long strings.

Applied, thanks.

--jSXJDi5r/aeatSyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9jwAAoJECTWi3JdVIfQonYH/ifXdzpplo/8IlViZGC1vMpp
m4qDQSL6jPnPzMzK/+MAQtfNeTM74zYjF6TYSnKbj1gwneNERlugmXP9JjC0pS78
aLxFojtY4gfIo+smF2s4qLtoBrRHkTp8hgwoVX2urNsqg66ONKAViuTruAwSmP9N
przE7WZGDgA0StqYjR61YyCTjxswXug383uO6P3wlo1ggZ17zkqxiU1uw/l2GuJF
WXRhHNYvriAZVPBySwuclkXc9P4M2s0RHHzDWFHMrAf2g274LpHHmDwJctwHHmuE
zGc0lKpZlnQLOvpg53T87fkvVdWJftvfh/uRrLbOqSKaFxQ7T9XVqOO0TChmdqg=
=LbQs
-----END PGP SIGNATURE-----

--jSXJDi5r/aeatSyx--

--===============5210714798350818146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5210714798350818146==--
