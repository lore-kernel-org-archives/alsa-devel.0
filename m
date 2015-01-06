From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5670: fix bit definition for
	ASRC control
Date: Tue, 6 Jan 2015 11:03:25 +0000
Message-ID: <20150106110325.GU2634@sirena.org.uk>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
 <20150105181714.GA2634@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70103ABE3@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4472974520577915517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 358D02604E8
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 12:03:38 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70103ABE3@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4472974520577915517==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7d9k4kQHj3EPdFyS"
Content-Disposition: inline


--7d9k4kQHj3EPdFyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 02:08:45AM +0000, Bard Liao wrote:

> > > This patch fixes bit definitions for two ASRC control registers 0x84 and
> > 0x85.

> > This appears to do something more or different to fixing definitions - if it
> > was fixing I'd expect to see equal numbers of lines added and removed in
> > blocks identical apart from some numbers but this appears to be adding
> > some new definitions like these...

> Maybe we should call redefine rather than fix. The previous definition of
> registers 0x84 and 0x85 doesn't match the register's description. To make
> the code more readable, we would like to rewrite the definition of registers
> 0x84 and 0x85.

Yes, if it's just redefining the definitions that are currently unused
then it should be described as such - a fix is something that should get
sent to Linus and possibly also to stable.

--7d9k4kQHj3EPdFyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq8D8AAoJECTWi3JdVIfQSwEH/j8hnPZwSCMCx3Ij7XjluKTw
46AZ+yVIG/YjyedqBuRqy2QxIHWObz6VmQSI8VrnaTD2JBEEow4LXRkRpNxHqNsJ
q8iU0BkjX/4+K/wlQ5jucGgqYLJzItkZae6pQMf/05+8AwT69RmgVu8olYEA6jjF
qk4/LQy92PDs8Sp9IYG/YQ19Q/aY9tJ5XV7eD1qZmBuuKcsF/47uiFbn8YtvtFbn
2XALqmQjH47lK1OPxfh9C3uXibuuicl08NMKK/R9AdNrFkuMeORcddOTkGrd4ms8
DX8APq5c2pDfdvqhxSWlIYIiS8OacYq3NK69osjNK+l3Tv8mcXok7jnkEUNtckE=
=EidT
-----END PGP SIGNATURE-----

--7d9k4kQHj3EPdFyS--

--===============4472974520577915517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4472974520577915517==--
