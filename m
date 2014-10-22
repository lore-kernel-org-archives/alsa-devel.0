From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: always cancel any pending
 delayed stream shutdown
Date: Wed, 22 Oct 2014 17:28:02 +0100
Message-ID: <20141022162802.GB2344@sirena.org.uk>
References: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6345850007372553646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 462C82651EE
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 18:28:24 +0200 (CEST)
In-Reply-To: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6345850007372553646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="olLTNZSltDMg5Vbm"
Content-Disposition: inline


--olLTNZSltDMg5Vbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2014 at 04:14:53PM +0200, Hector Palacios wrote:
> After playback a shutdown is scheduled to happen within 5 seconds.
> If another playback takes place before the scheduled work times out,
> the work is cancelled, but if a recording takes place, the work will
> shutdown in the middle of the recording, causing problems.

You're not saying what the problems are, just that they might be caused.
Starting or stopping a playback should have no impact on a running
capture stream, users could always start and stop streams manually
anyway.  It sounds like you're working around some problem in drivers.

--olLTNZSltDMg5Vbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR9sRAAoJECTWi3JdVIfQXi0H/3EGvPNcukAYl4gEXnEPVEUS
8uvXAAcfDe2Y0lqGfNAMvzQoUTTQ9K6Nj2I/PIpY19PROZyk5HVs6fgnj115eFd6
lz2j5YJznFwegCFqsPoRWDijP9sYv+HeuUMyDfoz5/IDmz251h7BkFgoL2XbRBXn
vROR1X5Y4IHzg6cd7osOy5yDFOUpp96OSRy5gcuEmzM0zy+PAFJuFool7ssockz+
YQbNFDn/q3Q1QXcdFGm8UjzJ/SIQe6xp6WVq3+ezdvXq4/m+amm05R/Gi1Sp0yxy
PNCdp5CZdHa3Iz0N2uO+sbSWOJq0ppHgQWg8VQIn+aAlZfhNGMYTkYawpkyI5I4=
=nDK3
-----END PGP SIGNATURE-----

--olLTNZSltDMg5Vbm--

--===============6345850007372553646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6345850007372553646==--
