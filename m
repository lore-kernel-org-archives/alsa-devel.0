From: Mark Brown <broonie@kernel.org>
Subject: Re: How to specify data format if playback/capture
 were different ?
Date: Sat, 25 May 2013 16:03:45 -0400
Message-ID: <20130525200345.GC32043@sirena.org.uk>
References: <87ppwl3v71.wl%kuninori.morimoto.gx@renesas.com>
 <519B615B.5070409@metafoo.de>
 <87y5b7ltcd.wl%kuninori.morimoto.gx@renesas.com>
 <87wqqrlswy.wl%kuninori.morimoto.gx@renesas.com>
 <519C8516.9050307@metafoo.de>
 <87fvxfl7hx.wl%kuninori.morimoto.gx@renesas.com>
 <519CAED5.3070201@metafoo.de>
 <874ndt2hht.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8475519602012812055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE50D2619D6
 for <alsa-devel@alsa-project.org>; Sun, 26 May 2013 22:37:40 +0200 (CEST)
In-Reply-To: <874ndt2hht.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8475519602012812055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 08:18:09PM -0700, Kuninori Morimoto wrote:

> > I think it is rather unusual that you want or need to set different formats
> > for capture and playback. Especially when BCLK and LRCLK are shared. That's
> > probably why it isn't supported yet.

> This (playback and capture wer different format) is first case for me.
> Maybe ak4554 is very special.
> OK, I understand, thank you very much

The reason this is only supported is that there's an assumption that the
DAI will have the same clocks for both directions - if the clocks can be
formatted differently then it looks a lot like two separate interfaces.

It's also a bit odd to want to use different formats, there's rarely any
reason to do that.

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoRkeAAoJELSic+t+oim9Y0kP/iPRP+Wr/zmB8n4XuEEEYqAX
mrmT09LcMlt4sjIQJ1/E2rqhMgNgLRHbiuA4u2RbzEVNIP8uS6VrfHgHIWxfUBKb
tSGWf5tsQCAzBvxoFB+3BXiAPxhMiPpIPeUFhX5CrG6GsJjBfSjK+zAs97g3+kF4
/EVafIkEtP5OdGzi2EU/hQSIG+5WGCCgJlwuASwNnuWXx7Guafzre0oegLaJVL7f
eswUZrTDr24rrg7Pu5KtkwmC5US9u6dvfyxhEyg7Oq3t8wDRHJwnEoPfI3VbLeXC
Uf6AbvEdCHVIASf3Xrq3Ergw7agY2rghGNea+PMAlqta+97m2FpM1gsksYOPlVcN
wbcnwqD82K7Z1IspsBeBmiuqF0xhtr6mVsV773nksSJS86uHTsSRogiyv86BLuYU
oTZevqGoZqitr8NtijSIbB2n4wFpv+/ttZyNWQ/kKem40K6Pqdt+2biJ3PnHiRc5
8GZV2kL8wEeDwUMiQuzyICkpuhALKNVIdG/H+qWA80UX36SpwpsZMJi7o78timSv
/iBY6JhsQWVQZu6kKbU4h+cKf0rnB46ZCLvkOggl3VDb1ftjyGWFHESpTkkiJSBO
vlkqoHJ9KJbWj0jKyMRMtYMzLQO0qdI5QOe5nNC2VvKCrqNdeBJmhdSq0+bAgZ0f
D9ZofdosMAixQ2zWnWjv
=7/a5
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============8475519602012812055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8475519602012812055==--
