From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: fsl: imx-wm8962: Grant
 hw_params/free() permission to control FLL
Date: Tue, 10 Dec 2013 11:15:05 +0000
Message-ID: <20131210111505.GE29268@sirena.org.uk>
References: <cover.1386344000.git.b42378@freescale.com>
 <105d07ac1a77bf99872d75608c97b3342079bfb7.1386344000.git.b42378@freescale.com>
 <20131209175640.GL29268@sirena.org.uk>
 <20131210051740.GA10655@MrMyself> <20131210102523.GB12042@MrMyself>
 <20131210104745.GC29268@sirena.org.uk>
 <20131210105135.GC12042@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8638401530603687274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F331261A86
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 12:15:08 +0100 (CET)
In-Reply-To: <20131210105135.GC12042@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Nicolin Chen <b42378@freescale.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8638401530603687274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I9vJvZLOUpy8mCjG"
Content-Disposition: inline


--I9vJvZLOUpy8mCjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2013 at 06:51:36PM +0800, Nicolin Chen wrote:
> On Tue, Dec 10, 2013 at 10:47:45AM +0000, Mark Brown wrote:

> > For this sort of question you should follow the DAPM graph...  the
> > headphone and speaker mixers have IN4 and MIXIN as inputs for analogue
> > bypass and the STL and STR paths provide digital sidetones through the
> > ADC and DAC.

> So I could test it merely by using 'amixer cset' to enable those switches
> without doing anything to power WM8962 up as long as my operation follows
> the DAPM graph so that the DPAM would automatically turn on the regulator
> for me?

Yes, as soon as you have a complete path from an active input to an
active output the path should get powered up.

--I9vJvZLOUpy8mCjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpve2AAoJELSic+t+oim9wRkP/3nGtH11Vu7mPD5WiGzUxZw7
DojbN7+pImi9XwvnhPO7IipCRIGF6wRY3DVfeqV/sMxqb6zFSYYFm0+aX/kvsbQK
rAss9vd+umLfGDDDCjoc//sO3/DfakfxGtLWUgEj0TLvGpQ7olRnbraXGS7jIPRA
wq1oKlQcqaWw/snyVrETZWoD5bSRpWoDfkDjyJaepWgZYRxj8mHthxqRS7Rc5aGq
3Kd0T5hj3Cahk3xgsWaBydrjI40hzNu++K718yiYtpicmo+8LZJeJS9oXBs7DUPf
kdfpfgh9abb0pUJ8y/SaabMOYEPQJHT6ovZKUT8O+zihw67ZgyE2hkvnv9b5cjvZ
aA9L3MJJRvehOHiLQQ/XNFex6eUzZdguIRXLUCFTSZtt6dS0FdCnNso3cVzJ7zH6
sRROo0Jrhr44Bk2e4FXEea6g5dK2SfjjbELNZ/0HzwdZOfvN+lIvqrO6BCosz/95
lPUeiSTi6ijKE+Hi1FlcDWZzV/BGi8s5Mi8H7rW1hVhhrxNCXAlxLigxxLkSZ/I2
1zxEFR6yLa0KunjAxIPdKaefdGbzQ3co6VAf9Nww2FYffCmN0iZTwo1Y33rpBiA1
Mf0yAqceU3ss+og6t5LeKWRIHREbkhfFVOWk6vjGdERwySH9fBHUDkQ0Ab3hF/3R
qPcYvhyLDTWTEUsb/Zmb
=SXDO
-----END PGP SIGNATURE-----

--I9vJvZLOUpy8mCjG--

--===============8638401530603687274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8638401530603687274==--
