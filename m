From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8960: correct the min gain
 value of some PGA
Date: Thu, 10 Sep 2015 11:58:21 +0100
Message-ID: <20150910105821.GG20922@sirena.org.uk>
References: <22ae1784eb84bf45b23bb7095b7dea8a116c0c2c.1441798038.git.zidan.wang@freescale.com>
 <20150909114954.GA30013@edi-sw-dsktp001.ad.cirrus.com>
 <20150910011529.GA13451@shlinux2>
 <20150910082420.GC3483@edi-sw-dsktp001.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2189834656013207571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0362614C4
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 12:58:31 +0200 (CEST)
In-Reply-To: <20150910082420.GC3483@edi-sw-dsktp001.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============2189834656013207571==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2015 at 09:24:20AM +0100, Charles Keepax wrote:
> On Thu, Sep 10, 2015 at 09:15:32AM +0800, Zidan Wang wrote:

> > > > +static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
> > > > +static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);

> > I think the min register value will corresponding to the min gain.
> > So value 0 will also have a gain value, although it's for digital mute.

> > Refer to wm8962 codec driver, beep gain range is -90db~-6db, step in 6db,
> > but it define the beep gain like below:
> > static const DECLARE_TLV_DB_SCALE(beep_tlv, -9600, 600, 1);

> I might have to defer to Mark on this one then, if it is normal
> to just use an additional gain value for mute in this type of
> situation then it is ok with me. But it doesn't seem like that
> would be a sensible thing, as you are asking for -97.5dB but
> that is not what you are getting which doesn't seem like the
> nicest interface.

The last value in the scale macro is a flag saying if the minimum value
is mute - if it's set to 1 userspace should know this is what's going
on.

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8WJMAAoJECTWi3JdVIfQR5oH/ixk0bFv6QmAD5BxUXP59is8
bgc/z0oanLAd0L+fIJni+RRFDPpGD/zpwGWDGG4kiQWJK3GwlYP6W1KyXqPc/rc6
FNnCzGQ7vyG+q4UybxkRHkAxGI9OkZymgAvWuqSBXecRAfbkdbA0dlPBwq1G1lAT
10DtYM3cgVsyBblmCdgmXJE39pO+HIuEYn7yLxhXVM9VDQYpPN1FBen1BBV56B6P
nYvQWNp1jyBbl5qPwl16o8ADFSKRFf5S266R1BLq1cXc05nDg6k+LmmFLGrNFjnE
vd6aorctFyv1oQlH6UQes0EA/5+QWTtFSrKkvbi6Ic4DztXXNlpP1RXL8RCay8k=
=KC5S
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

--===============2189834656013207571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2189834656013207571==--
