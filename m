From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Tue, 4 Mar 2014 12:58:15 +0800
Message-ID: <20140304045815.GL2411@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140303050745.GP2411@sirena.org.uk>
 <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8597456366197642331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC0222658FB
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 05:58:20 +0100 (CET)
In-Reply-To: <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8597456366197642331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DoZHmsciC1yDvY0+"
Content-Disposition: inline


--DoZHmsciC1yDvY0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 03:48:02PM +0800, Barry Song wrote:

> here the clock is an internal clock in the internal codec. the
> external clock of audio controller is managed in system suspend/resume
> as you see. but they are not managed in runtime suspend/resume here
> because the external clock is always enabled to make sure the charge
> pump to be working to make the board have stable current and voltage.
> otherwise, touchscreen ADC will not be accurate.

Why aren't these drivers keeping the clock enabled themselves?

--DoZHmsciC1yDvY0+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFV1kAAoJELSic+t+oim9oMgP/0JVO8ZSppiZ2ROoUBXVzSP3
HmPTn2nTPelWxrgGXDrVs/7WtXL0lEkwHlSdNAoNTTPigDWxEeV+4O9pTsc2IZIX
bHH92P6dCEDvaOKEUoFyLV6hj1zHHFvMkI5/rRSJgvV1oSNcsHBkoZ2Bi6jr0MNN
P7hlKhr7A74ChlwepVsQ5PQtSbISuV0oQE/0/YkeU7TpZXEKN3KwOgHOz9dD1dir
CupVbVuILIpnRd1z+sPZUwBtmgmQNeCQYbEjcvk4EdLj4mVTgY/aR8cyCKkKohcc
yVdgUyF9yyTaNitlw8ATfsTbBBFZ+lEIIjOgHgU8i7Xrci0DEeo/UTfrkyrg+a9L
h3xzBJmFhHcP3XBAkfuQXg2NNtWf6QRyCYCx9Kl6Yu8nHLvZ2Dbwcjjd27P+reqi
WQg8FujA+aXfNbH6jx6ijSpeSGlt8m/ehTcUHxO2EpJXZlgoOfabnMiy8P1I9Iqu
LIOIQa76AGJj7ZlOVyD9BC1s7O0kXH8Rb95Rrliql65888h1s/OByEIB/Vmml/hf
aR94zCStjWz0T1SIELFUTkF63Ad8F5Nz0dtnvflX1ZmJhQIikvtNeuG1FdfCrEeT
yytj9z3VgtrsYw7XEGXUgj6fLv0AlutUBdg2VDg41mojQXxLzKsHvdsNMrmWO65T
3VxhdPKeyWw6w1I7GP17
=dJow
-----END PGP SIGNATURE-----

--DoZHmsciC1yDvY0+--

--===============8597456366197642331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8597456366197642331==--
