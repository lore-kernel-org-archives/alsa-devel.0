From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Delay and retry reading
	rt5663 ID register
Date: Wed, 8 Nov 2017 21:20:54 +0000
Message-ID: <20171108212054.k7iqelprbl4agimy@sirena.co.uk>
References: <1509949082-21443-1-git-send-email-oder_chiou@realtek.com>
 <20171106113014.674htnbx2i2dk2as@sirena.co.uk>
 <7EB0DE829A537248AF2ED30C97D12694023CFB9D@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5523816490263981332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A430C266EDF
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:20:56 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694023CFB9D@RTITMBSV02.realtek.com.tw>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>, "cychiang@chromium.org" <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5523816490263981332==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6oxxn2bgkp4rmhje"
Content-Disposition: inline


--6oxxn2bgkp4rmhje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2017 at 02:21:21AM +0000, Oder Chiou wrote:

> The issue is similar the patch https://patchwork.kernel.org/patch/9681421/.
> And in current project, these 2 devices were connected to the same i2c host,
> and they meet the same problem.

OK...  can you resend with the log message all on one line please?  That
makes it easier for people to grep the kernel source to find where the
error came from, it's more important than 80 columns.

--6oxxn2bgkp4rmhje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDdTUACgkQJNaLcl1U
h9B3igf9Eo2ipmpUiUN6eXYADQMkZt/NecRAeQfMgXv35J459wU4NdZ2vl8emx+b
IPgGfBjzxRWpwCu6n1hOBftB67EwUL0JritYS/Orpp8F941P00e0JoY4QLdZwnK6
DAB9G7Y1+7Nno5G9KsgP6nHN6orO94Ls90ilnXcfKgYzNCMgGdKkiaet6M4qurQa
GVrjMqr1owyYIGgix4mpvIRkGbif42vTfJk/SbnKCYW8osF6OeTzJbQMnKGx8GRC
DqD6gxBFlRlCIXVCAsYfNxb3GOMdnJkaoFJr8TRn3zsH9Ihp5uw+lLluRgrsk95J
o4WV4R4klJrKXglFAo361TYiv0FQig==
=Cclm
-----END PGP SIGNATURE-----

--6oxxn2bgkp4rmhje--

--===============5523816490263981332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5523816490263981332==--
