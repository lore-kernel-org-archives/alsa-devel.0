From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: davinci-mcasp: clean ip
 davinci_hw_common_param()
Date: Tue, 12 Mar 2013 19:04:19 +0000
Message-ID: <20130312190418.GZ19942@opensource.wolfsonmicro.com>
References: <1362748778-11076-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2077729164114889799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94E6D265DF9
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 20:04:20 +0100 (CET)
In-Reply-To: <1362748778-11076-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2077729164114889799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mu4zWe6QekgCAJVd"
Content-Disposition: inline


--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 02:19:38PM +0100, Daniel Mack wrote:
> As pointed of by Vaibhav, commit 2952b27e2 ("ASoC: davinci-mcasp:
> Add support for multichannel playback") duplicated the logic of
> counting the active serializers. That can be avoided by shifting
> the code around a bit.

Applied, thanks.

--mu4zWe6QekgCAJVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3wsAAoJELSic+t+oim9MVAP/19R0aQ1h0Gca9SCUXxNT3z/
oisGIPEVAJaRjXA+lK0qnctiwyA2beb5J1GBt13iwSOFm2FYtRC4ncouDYghRPu4
bba4hNwFT6SGN+UJvGShTBv2LmfiKsATeR4Qx0Nu2UO2im/1pWon0SYDO2Ga51S3
LY7bmEYNhtn9YHZ99+4oWdta3bYzKbtZB440YomxTWMCbskDw7B4vKn5nRqpaJ7w
RZnsjI2Y91sF2Kkv3T9ohGrCEiJz0hjzGUEbUBDhpWeo+/mJvXk7rmsnx2doQYDZ
W44rf8Frilww6E487GuCi9IH1C5grjnooaWKS/cbmF9Ssn9Gwq/JM5+DoX5+s1Qe
ab6ML6kJKNUgzgA72H0tv+nCQSayRLWGvhyyN3sossDpOXAay0gNT6YxIWAwv4/E
793OhTZqSvHinFR+7JB3mgv56JCzpqeDj6tz8wJibGTK/PUnFLtyvGzCt9Dmj5/U
zpfVnOsLXTNQRFvkKYPf02RkmSCJG82Jr9Wi0SFvNSzEmaqixIb/hIN1MnF5gAzT
+lz3V/24x43KKTVHTbwCM3z5JJD8JSFr8W/VsTYXrwrTpNeSJ+H8m57q9OY4PMtj
Hz++7kzxDVgXldUOF8VwgowSBud6+AScwImkHsw0+IP5Zb8et82q3GPe92nDI6G6
bh6DBpxTK8IheYjEZe/x
=lJGi
-----END PGP SIGNATURE-----

--mu4zWe6QekgCAJVd--

--===============2077729164114889799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2077729164114889799==--
