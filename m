From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: dmic: Convert table based DAPM
	setup
Date: Tue, 27 Aug 2013 15:32:10 +0100
Message-ID: <20130827143210.GM10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0843071985421541134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B87E92651D8
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:32:48 +0200 (CEST)
In-Reply-To: <1377611461-3638-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0843071985421541134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMkrXc3gAYLRVOjR"
Content-Disposition: inline


--sMkrXc3gAYLRVOjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:55PM +0200, Lars-Peter Clausen wrote:
> Let the core take care of instantiating the DAPM widgets and routes, this makes
> the code a bit shorter.

Applied, thanks.

--sMkrXc3gAYLRVOjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLhmAAoJELSic+t+oim95DcQAJEQgJTPyrsB+cgsw92c08ix
XMVIREfxC1UREWD6Bt5XE/mXhBf/9jRkxUhttyYZfgBghkkXR3WqYKSg4tTGga5/
CvqyVwYzLdjKPfbfiBWftFIIeIiVvByvOhWHkd2Me6I/IY8BxGFyFakAMoPZx1qP
uprhkkd68cqQuLv+w/lq0kG2wCL4sFlFP2jE8m1PPslK8nU0f5Jgy2hpO7JYaphO
8SO5f2bnXEXHvEuu5M+Dtl1l4Cds2aXstUtmD9+hIqJuA+iB+uiGYT15IUs8fFfF
Oi1t9zsccdtpReef01WEpz8yAZ4ezE/WsVrms51oioPhIfgWqxI8F8D53qOOzZu5
enb1wv6qaABjEvQQW50W/ALGv24woNhe8Zeqy3tZE0a49OHBiM+qWKBAnLWStO94
x8/Y+fD/XTuhZKc9ztE8PGpilB4S5334lF4Zbx99R4WqS7O4YD8giGZCjaS8jSmm
9VAz9sSvIrSikI23OY+3aVC9vNBFRZox2wS9raTlFihpFSagVuHf8sOkmHJI2LO6
2cRHXZy1wA5fQ+g1RDlTffRMxx1Yrmh1qIlszWH0GWF+w/a9H42I4EsQm4TEXs+x
paqTVDTOVHsPXN0uICAdPYzXmJazNgSoIXrc3MzSVT9rnVUZZ+wby+GuDfCIV5p2
6cR+1nSM3m692mvWetXu
=me3e
-----END PGP SIGNATURE-----

--sMkrXc3gAYLRVOjR--

--===============0843071985421541134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0843071985421541134==--
