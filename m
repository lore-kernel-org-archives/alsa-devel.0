From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
 MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 16:37:36 +0100
Message-ID: <20131025153736.GA26122@sirena.org.uk>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3643708306268955914=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 759E0265669
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 17:37:41 +0200 (CEST)
In-Reply-To: <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3643708306268955914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 10:01:15AM -0500, Brian Austin wrote:
> regmap_register_patch fails without the MAX_REGISTER set to highest
> register written to. Increase to register 0x47

Hrm.  It probably shouldn't be doing that, unless there's some great
reason I've not thought of - this is for random undocumented registers
which we ought to be able to exclude from the the register map that
Linux knows about.  What's the root cause?

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSapA3AAoJELSic+t+oim9s5wP/0g0BkOjwxZZnSUc9Crn+lmS
8+Y4GXRn1/gkGq7Ks4mn1nyzY4NdSujqexfKtYAxSpNsPrF+5jg2Qasf5ES9jFAv
/WdQGaxA2wwh9WtBoD9i6MHiFByjszTRxMw0EcY7vi1CSmQNBVxoUdqzkCaE8Dnj
rUpHF/Lv3d5j5o3RpwiY2MXkv1yzNYnIm4en+VkCjngx/y4WGKNbJVQ1rhSrJ5s2
n1p/gwOdHN6RelERrADQlFJbj4D7Nbn/ypLiInTkKoy+1FnnnRYluwTRZnKVtgn7
WmM+Gy9aJmvfA9/sMxt5qdSl7rRgAOEJCPUXhfg6s/7PaNCpExeIVSbXNjFc84YL
FM+iqi1UgWJRMwIxthD0g78hflqsw/v/CtomnZViUJyamudN1qxyC6eVAmhAIxJs
RWL0ZMnJt55RSoDQxOUkUNRcItaECxmKnsqVnRvJpyJ4qEg4GRow9daMeGtZTFer
1+o8e54WU0wDpz13IKH1Pt7wDSgFtUTeZ82yHK2pCwRVz8gijHSA8qKzhTnyrB3O
ogMTmtmrEBew4exwnYNhSg+AhLeASANjkIbi5jwF9R2cSSKUs4uDTckyMgoPauDj
45ge3e1WR/qUKN/Luu3f11qvJEpPInXAxrh0WkSPaw2GNmYNkK42W2bi+oSkspxZ
Q8cirXzXjKvG7FECvUiq
=tBM0
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============3643708306268955914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3643708306268955914==--
