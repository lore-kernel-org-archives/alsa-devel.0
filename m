From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: imx-es8328: Fix of_node_put()
 call with uninitialized object
Date: Tue, 7 Oct 2014 23:52:36 +0100
Message-ID: <20141007225236.GN4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6414407551516963458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E87E260605
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 00:52:52 +0200 (CEST)
In-Reply-To: <1412698794-25536-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6414407551516963458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QIE8wBgbk5Wqyq1O"
Content-Disposition: inline


--QIE8wBgbk5Wqyq1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 06:19:53PM +0200, Takashi Iwai wrote:
> The of_node_put() calls in imx_es8328_probe() may take uninitialized
> pointers when reached though the early error path.  This patch adds
> the proper NULL initialization for fixing these.

Applied, thanks.

--QIE8wBgbk5Wqyq1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNG6zAAoJECTWi3JdVIfQyOcH/jGKJDKJLM7EfrlF4sMWoAoQ
7FN8KwoxRs5n48AGxXx1XVzfuux827EXwEBD1kE5ALs4G5ow1/HLlxnvPu45ELwS
nCNd4NtBwD7QGOLE1qF60H7+hSL45b45ahlJoKKxVbdbYVHBI8yBTuZtbmLHhM69
PVUaUuZVfQJ75avoGK0x9Lkew6JGzigXCd4vD4DzI77uVwZvr742CxXDAxsOgx7w
4kh1k8+3SRwTDGyNF1m5NgHq7jx1qj0Jcl1m9sQZZG2V4uRqLP2Ps9iS8PEvdCbx
91/WPkOS1C6N6a5rpi8dZCNAXiGzZxqziU+M3a0WAuYjQNL8FekFFjLDThdHdX0=
=00hV
-----END PGP SIGNATURE-----

--QIE8wBgbk5Wqyq1O--

--===============6414407551516963458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6414407551516963458==--
