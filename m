From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Tue, 6 Aug 2013 18:04:30 +0100
Message-ID: <20130806170430.GL6427@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8263947325290679628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 034632616FE
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 19:04:34 +0200 (CEST)
In-Reply-To: <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8263947325290679628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+278g007AL/ykmV8"
Content-Disposition: inline


--+278g007AL/ykmV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 08:09:18AM +0800, Barry Song wrote:
> 2013/7/17 Mark Brown <broonie@kernel.org>:

> > There is likely to be a control interface for the BT device hanging off
> > a UART but it's not clear there's much more meaningful data for those
> > than there is here.

> so the idea is that we don't add codec platform device in uart, and we
> add a dt node for it as we are doing here?

Well, I think it's more OK to add a node like this one (possibly with a
link to the UART) but if you can add it based on it hanging off the UART
that's even better.

--+278g007AL/ykmV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSASybAAoJELSic+t+oim9q8kP/0wo1JY4mrWOps9Rwj/MTBqs
t40xs1kWcnjs2mPA6PG7gY5HSAjbgNzbHQJz2+AjGVTtZxdUQKeDpTKcy7Rx2P/C
FHp+pjgK9nlCUyfha1cSmFTcGO5+EbDjbET4YovSya9LyQt+U6VAcLXTynVXrey9
HUdeehpaJvPZutmGNdKnNzB2vhpVtyHcAb2g38JwktO4O6AcP8Mm1onxpXD3USh3
Wlc+9zoPEBvQcDd6grG/uBxZ94Sf6ddTRE9axWMdgbF+jKN8s0AQ9e8jDF7DWBLh
ZASTnuj+0TB6eD/iu/3iXy90AgYxEIEMxEDG/KMi8uMpMOOAq6CvGKyhg8zbq3cC
CTHXtC4BvBRbsMhjC4Ooni/bFKdcpDnYn0067R9ImW8O4wANbwwQLIv6hYSPud4X
dXEqvp33+rBN+nvLOtaQqHSALw4FGuDqn3YW9Z2tiG1iUrXaPtkxHtzyQ/4irzu9
l781e3we5QbwtwpZNcsbF3WgPyvhuO9Q6jtt3uaeDVAoa5ci3sFo2+Q4QZA2NWGf
FERz+jagP6GezJ9Njaj+N71FG7yzzgg4BDV0OTLqK8vohE87lU7+YtyMZeETM65v
yTQ96Qy58w341zJJJUbMaTCFbSHUjopXed9OmOKGZD2sTLw+TuUSlJfjm+J4hXjS
D4Qox0KggiVCkC5IFxa6
=wMc4
-----END PGP SIGNATURE-----

--+278g007AL/ykmV8--

--===============8263947325290679628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8263947325290679628==--
