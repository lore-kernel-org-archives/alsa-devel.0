From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rt5645: improve headphone depop
	function
Date: Tue, 12 May 2015 19:50:49 +0100
Message-ID: <20150512185049.GU3066@sirena.org.uk>
References: <1431434585-26745-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0852512300144143140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 286E626587B
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 20:50:59 +0200 (CEST)
In-Reply-To: <1431434585-26745-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0852512300144143140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dXvu6+ixFx2ZffE8"
Content-Disposition: inline


--dXvu6+ixFx2ZffE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 08:43:02PM +0800, John Lin wrote:
> We add a calibration function and call it at the beginning of i2c_probe.
> The calibration value will be kept until codec is shutdown. We will reset
> the codec after the calibration is finished. So, we set cache_bypass in
> the calibration function. The benefit is we can shorter the delay time
> in headphone depop.

Applied all, thanks.

--dXvu6+ixFx2ZffE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkuIAAoJECTWi3JdVIfQXEsH/1KvzW6DfovQx1c5B1SvZh5O
QfyIKoSYpRdo1CD/vAMcJv9QiABWGVC5cYl52T0seqtmNSek/h1FhUWbaj5fLiWm
RSqJPh24WXwvwk72jYWtxyglykvNYtmfdQnNa2HlWm4SkZy0NN7j6IO8z+aVXZlX
Vih6z4rEwlAFrEB2sWV4taAr5oJ+d36zIAjwIupeZyQDvXdv6dfT+Cbp63/BovhI
ZYwRnKZBeuHypaVamNKS6kRrXthzFUqWuGnI3bdiLs43JorOYM90cxXnL99G72xC
pHwbVWiJNjaBuWct2gV9ESZ32keLsqp/Qeh2LIAHlB0oiUUqRtTo5nwH/a23WZg=
=Mo09
-----END PGP SIGNATURE-----

--dXvu6+ixFx2ZffE8--

--===============0852512300144143140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0852512300144143140==--
