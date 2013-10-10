From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mc13783: add mixer controls
Date: Thu, 10 Oct 2013 10:44:22 +0100
Message-ID: <20131010094422.GE21581@sirena.org.uk>
References: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
 <20131009151336.GO21581@sirena.org.uk>
 <20131010073411.GF14042@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6074777709895903447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 08FBD26031E
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 11:44:30 +0200 (CEST)
In-Reply-To: <20131010073411.GF14042@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6074777709895903447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ez1fCABS8b19cfNB"
Content-Disposition: inline


--ez1fCABS8b19cfNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 09:34:11AM +0200, Steffen Trumtrar wrote:
> On Wed, Oct 09, 2013 at 04:13:36PM +0100, Mark Brown wrote:

> > > +	SOC_ENUM("Line out Amp Switch", mc13783_enum_arxout),

> > Switches shouldn't be enums.

> Hm, would "Line out Amp Source" be correct then? Or just "Line out Amp"?
> I'm not really getting the documentation in that regard.

Either of those would be fine.  If there's no guidance you can pick
basically anything sensible that doesn't have a defined meaning.

--ez1fCABS8b19cfNB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVnbyAAoJELSic+t+oim9beIQAJAvTKkHGD0mscZgLmWPx9nz
ia1Ti9m/X0XdOhr+soQkTsKcYg0URWavyrVFSQwCvqpXmMOdb+kXhmA+zq9U7IeG
Uuyv2S7FH+amxHUSgDY5Btw/aYoqKGdCU+JNOH0HGGpQaX07VKyDlgDJVX/PfZvD
KNlvckC76vpS+8xC9EkGjGPz9SZfukc1OBPnDdN33oW+wdhXpi/1qmsjasUgNDRN
TMo6jfMfxqYE2A4ki8QpU/41R1a7RxG12tpav44t3uCm2+SWCniYmGBWFknZTDCO
Yd31lHWFgbGrbkBsua6JrevVPuDoEKPCMPktfcWbsFuP0rzx02uEbH0iLWOx94fz
rMdMgCfx2I7br0jKl69EcENop3JZ8NvNV3uRDQnXwnH/yHGYtzZ4kr/uYCJLnpTY
RQW0KV5tKpy7gYWAuytxWPvZmgTiyLdVBfx1cqNWSX4ujK/XP7G1RJjQ9JvrqzLD
lYQ43KGGB5epiqnWvmtH/NN8y/r73FFqpPDzWVT24nui7rh0fXo5v+G8x5fI1z4M
L/ctmyVySWreh/3ptK+DQQ7oEnzROnHcSBY2tPDbWLeaAk7PCubCVjTBrcN3ry5F
tUhb8hRx6Qv0uYZli2tW1y7rBToL6zFu77SCdulJJYXxtzcmguFIjEooZ9vMwOGj
lXZzggIZ9WM410mG42gw
=tAWl
-----END PGP SIGNATURE-----

--ez1fCABS8b19cfNB--

--===============6074777709895903447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6074777709895903447==--
