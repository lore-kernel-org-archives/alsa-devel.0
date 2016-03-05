From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Sat, 5 Mar 2016 12:51:37 +0900
Message-ID: <20160305035137.GX18327@sirena.org.uk>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
 <20160302103535.GH18327@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7340783904051620787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CBB02658DF
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:41:47 +0100 (CET)
In-Reply-To: <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, "zhengsq@rock-chips.com" <zhengsq@rock-chips.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7340783904051620787==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uJEjpDjzx36eGv02"
Content-Disposition: inline


--uJEjpDjzx36eGv02
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 02:45:32AM +0000, John Lin wrote:

> Yes, It is another mute control that is missing on current driver.
> This mute control is for headphone volume mute. Is it OK to rename it to
> 'Headphone Volume Playback Switch'?

No, you should call it "Headphone Playback Switch".  Please see
ControlNames.txt for details.

--uJEjpDjzx36eGv02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2lfIAAoJECTWi3JdVIfQXksH/j3c5/peH7u3Fz+dQo0PynbH
2C2wRKwVzM+Eh1J2EhhPw9WsE/EkxsM99FtSWsUbEQbd3YkFbmcrbveOnTVKmqjH
GcT9ndrfPh4H9bC/khi3hiRRkuMTFrPFj2o7yUfdoCMU26Lqhfu+aGEjeDm8+jh6
r2G8Qa+9cZtWYnc0f38kmT7k1ZFLN4X+1lpghzV/wfeVWYN6whvfwP0GYC2ulyQp
nvxu7DdX/pn5Fs/b9ot2yLc7YGGLvdc6PwkTF0MZl02Eo6hxr7x9FWWdVwSB7yL3
Uh2yG1oUph70FRVK7iTBI5WXBYwpBQXAm5u2PQMMYK729Bm1mi/dqGFbRk+o0CM=
=EOWY
-----END PGP SIGNATURE-----

--uJEjpDjzx36eGv02--

--===============7340783904051620787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7340783904051620787==--
