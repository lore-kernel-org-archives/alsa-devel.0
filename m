From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 17:27:06 +0100
Message-ID: <20120821162706.GU7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <s5htxvw1eqz.wl%tiwai@suse.de> <5033AB7A.7050609@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5687836481571763614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A98F6265FFE
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 18:27:06 +0200 (CEST)
In-Reply-To: <5033AB7A.7050609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============5687836481571763614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="REOXmE5zpOGz6VLu"
Content-Disposition: inline


--REOXmE5zpOGz6VLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 05:38:34PM +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:

> > It's an interesting idea.  But, in the case of HDMI, there are no
> > multiple jacks, so this won't fit.  [...]
> > The primary goal of this API is to provide a way for apps to decide
> > the channel map for multi-channel streams.

> Indeed; including the jack location/type would go beyond what the
> channel map is useful for.  Playback applications know what kind of
> multichannel stream they're playing, but they definitely do _not_ want
> to decice if the output should go to the front or back panel.

> The channel mapping is a _stream_ configuration, the other routing
> choices are device setup.

Perhaps I'm missing something but why would the availability of
additional information be a problem for applications here?  The idea was
purely to punt the description of the outputs attached to the stream to
somewhere we already need to use to describe the outputs rather than
having to map the two formats together.

> At the moment, we lack an API to provide topology information.  But
> whatever form it takes, it should probably be independent of the channel
> mapping.  (I'll see if I can find time to do something about my media
> framework patches until next week.)

For media controller?  Everyone who's looked at in detail has expressed
concern about it being too heavyweight...

--REOXmE5zpOGz6VLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM7bTAAoJEFJkBDiqVpZ4Z7oP/R/lemF7KR6fZbeTseHWd0Hl
nvGlTkqrATL+IIfkWGnKQNELk1EbJvCW1t3XckDVLrFcYWxYc0iCmMsqNDqYMqO2
fE1VBarhij2l1XQKhBdCgAIyuAf/otZDAuFUB3RTKVwLOo0D8LQQl9cyfJ4y/Q+g
yA51v2LOORYiwGaKXWLw+7o2sPJm6SwFjah9oCdrtCMEF+W61nxuD6syiNSNgTb+
sXLG41GmDew4xTdgnWmUiLhX+GaDiOnA48W6CIC5FOGgLTJE+iMQc6u+iXPDtiHt
TT+etkwV7ipbzPEqpPcBJf7b1HXDDW7zcOjXoZnymlT57lcSW/JAUmbppxXp/e7p
bWp4EX9cI2u+Ga74h76edT1V8aZGGJJBaZKPh5J2GsjkrAk5BSzQbo+ZoJLjrFFU
tJpthcjg07ktrmlNnV68rsbtkc5XoF5XWXBiVDw/Jd+dVqbBPJTNeD0bUqcpkYCo
493AenXILo6ABYxrBRQrHdao1Fgynhg7byVXSmLQyFuNnq8c/O3nmT6ge2coobNk
5+8Bf1MGcspT/mlmeSYNpfo5yQXbu/zPLniefBVlFqSDsQ3rGkuHd8gRufMgMmjA
Fht2PrGZNtTuUbPA46Qz6T8gDbtfgcjQ1hWXeNaoyjXjnOYkDt3BlayvicQo4YcU
twI/iVsipsWewvFObcse
=ZnOV
-----END PGP SIGNATURE-----

--REOXmE5zpOGz6VLu--

--===============5687836481571763614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5687836481571763614==--
