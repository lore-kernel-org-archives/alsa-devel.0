From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
 make sure the speaker volume adjust properly
Date: Tue, 10 Nov 2015 08:47:20 +0000
Message-ID: <20151110084720.GB12392@sirena.org.uk>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
 <20151106104433.GB18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA36C9@RTITMBSV03.realtek.com.tw>
 <20151109140905.GB26072@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA3A6A@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2224975031066890296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E7B2606AB
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 09:47:27 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FA3A6A@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2224975031066890296==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2015 at 03:59:52AM +0000, Oder Chiou wrote:

> If we didn't cancel the delayed work, the function will return false to
> indicate the delayed work that are already on the queue. It will make the
> delayed work that cannot make sure to be manipulated at least 200ms after
> the last rt5645_spk_put_volsw was manipulated. In the log, we remove the
> cancel_delayed_work and there is only 95ms delay that cannot meet our
> requirement, thanks.

Looks like this has been changed (which broke a bunch of other stuff),
you need to use mod_delayed_work().

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQa8XAAoJECTWi3JdVIfQTV8H/AzR2MsaPu4iF840Mx3hJQwP
F/9qJKwDIysS1eBjw3Jp6Wtmak2Cd8ZMJlHQXm6YVJheV0BR47UNsPUKTAGcL2En
vLP1yTxr6nQ+rPsw3hfYqhGw3qm5AFIJ9AphJFTVqL1TWEGtfN9zhCFol4L1q2tG
ukPMQH0BhQYiWRKYyMHfhibi1mfc5Yyzi1nIKzmvVvodlr1PFX0yh+CufvR3Ou+i
oVfQRJdnCfjSwJo8ewrhp0LS7NtUk4c+ZQVNOP3HUIDRdHn2/7tpQ1xv4tVveGXS
XoUDuVEk/pEIdfIOr1VIgIH3D0M+e0SxSVfmxJMFMXwYwZ5VWy0BuifZWx6Oxwk=
=Zf/s
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--===============2224975031066890296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2224975031066890296==--
