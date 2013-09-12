From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Thu, 12 Sep 2013 12:08:00 +0100
Message-ID: <20130912110800.GI29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5564749780878843351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 67E2F2615DD
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:08:04 +0200 (CEST)
In-Reply-To: <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <oku@iki.fi>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============5564749780878843351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f3WXSwEsV7zDmurZ"
Content-Disposition: inline


--f3WXSwEsV7zDmurZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2013 at 02:48:19PM +0300, Jyri Sarha wrote:

> I have not studied the code enough to give a good work estimate about
> the conversion, but at least the current EDMA driver would need cyclic
> mode to be implemented before the conversion would be possible. It may

The other option is to support non-cyclic mode in the generic code.

> However, after taking a another look at the added DT bindings, I think
> we could survive with mcasp dma register addresses only for now. To my
> understanding those are anyway need in mcasp node. In DT boot the
> mcasp EDMA event queue could be hardcoded to the highest priority for
> now.

> How does this sound?

I'm not clear what that means in concrete terms, sorry.  Do you mean you
can just use the existing register ranges for the McASP?  Please bear in
mind that I don't really know anything about this hardware.

--f3WXSwEsV7zDmurZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMaCNAAoJELSic+t+oim9hxsP/0GcGj/JsA0VsRfqRTIHGuvU
Jp9p9XER4lZd8uDd0eekWjWC2zqPI/c43X9gH1BEfSn3DEHtOVjnz8mdbWkunrIT
qqR0j2O50XP4rqkCOej6SACdwNMiRHXq9aZER7V/hvukclPaaPQhzcqDVqM/cAfr
OjodTavTjpTApP6KR+O3PbZ455hWYyXIo9IfTayWQFiUD1A49Kig9NK1LTN+QqJ7
JtJ3tRow8AU7sajZd2qXXYJZvm6iZqBKsO6Vo0fp/FJ4UtiZEiAWRN8OXrVklNkm
NQ9wshFDMGNYSZNClycX4P/xZEYJvn/kq8PzUI/beT9FnY2Xgr7WK6CCR0VTH0aQ
rWDmtZQPZhVaPOiJSQmMqewq9sViWr5cc2ISeia+dKG28PfTsRyyDdTYPTqqxn0E
kZxSkTZmMgrl7dSoGY4U3twhogJlLoSE7aIDvm2cC6nOhRMurgIanoOnz3GUZSGg
tITzuSJo/8cdgIj5Of1grsga3FmtrW70sJZLtVLbBuOrbkZuiPsRViQ8SFvYI3pi
w9vezAPpaw3KcPchxoBRgSGH9nU3eiInj3dY/ReyA29uACZOd84+wQuFVUXvBYy9
6WWfaMNyGee4gsRNGo035ILCanzI4a4QSRP8OMAf7PitMRCeAQmA0uQkRVsM2+QV
Bb1ZWtGf7VUIAA6eyXpf
=lPA6
-----END PGP SIGNATURE-----

--f3WXSwEsV7zDmurZ--

--===============5564749780878843351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5564749780878843351==--
