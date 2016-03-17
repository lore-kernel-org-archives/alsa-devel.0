From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: support different clock
 source for FLL function
Date: Thu, 17 Mar 2016 09:18:16 +0000
Message-ID: <20160317091816.GB2566@sirena.org.uk>
References: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmXH-0cZ-VON3Ozttpaouuu+QWMTpdmB_fbELd+BhOUEaw@mail.gmail.com>
 <56EA1EB4.9000409@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4228487612988520669=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57722260831
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 10:18:24 +0100 (CET)
In-Reply-To: <56EA1EB4.9000409@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, YHCHuang@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4228487612988520669==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HO3Ykb1C9doWAHv0"
Content-Disposition: inline


--HO3Ykb1C9doWAHv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 11:04:20AM +0800, John Hsu wrote:
> On 3/17/2016 7:06 AM, Anatol Pomozov wrote:

> >>+       nau8825->mclk = devm_clk_get(nau8825->dev, "mclk");
> >>+       if (IS_ERR(nau8825->mclk)) {

> >Is it possible that clock system is not ready at this point and the
> >method returns -EPROBE_DEFER? If so it matches IS_ERR() but not a real
> >error and the nua8825 driver should backoff and wait a little before
> >clocks are ready.

> The function is used when playback startup not in the driver initiation.
> At this moment, we just skip mclk operation and let thing go on.
> Should driver return the errorno to machine driver to handle it?

Well, what should really be happening here is that the clock is
requested at probe time.

--HO3Ykb1C9doWAHv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6nZXAAoJECTWi3JdVIfQSFIH+gMEIfHnPpJvoFbTJ2y7hdJR
0tO6L8WuQAnhcfEzjRVTZPcmj5iKkU2OSSAE+9hMXiNzIejCAaJlbDIAt8hhEFNJ
DzSYYPAcL2yjZ0RAZRvL5Ait6poub1IrnGdfbehF2U2UXuXIaFKhUuVUxjRfOAgi
EsSZh9fCKhYsWIS/w+dagndOVxBA/i8VRubJ007Rh/Z1mq6qUKrI6XN/hcHxSZct
pbQfSXu1BcpXq78ydkZgs0IVremH24twvsyO33kEL/obGknVr6Hp9MOjMI8Ur3aJ
nKGHHua0yM/FBSzNDy/f2bl5o4QdFYC9OJJEeHKfVQAtSGjyi5jt3qzEV37e9FE=
=5bpT
-----END PGP SIGNATURE-----

--HO3Ykb1C9doWAHv0--

--===============4228487612988520669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4228487612988520669==--
