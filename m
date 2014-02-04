From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v2] ASoC: arizona: Improve ultrasonic
 frequency response
Date: Tue, 4 Feb 2014 00:17:27 +0000
Message-ID: <20140204001727.GO22609@sirena.org.uk>
References: <1391184978-14516-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391184978-14516-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6339557305200375280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D766F26158B
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 01:17:46 +0100 (CET)
In-Reply-To: <1391184978-14516-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6339557305200375280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2+gS0LBHjVo9w9tQ"
Content-Disposition: inline


--2+gS0LBHjVo9w9tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 04:16:18PM +0000, Charles Keepax wrote:
> Evaluation of the device has given some settings to improve the
> ultrasonic frequency response. However, this may cause sub-optimal
> performance in system designs with high output gains on the headphone
> path (0dB or -2dB), and as the frequencies are inaudible anyway some
> users may not desire higher frequency response at those frequencies.
> So allow the user the option to select it if it is appopriate for
> their system design.

Reading what you're saying here I can't help but think that this sounds
like it may be use case dependent as well and therefore something that
ought to be runtime controllable depending on if ultrasonics and/or line
level outputs are in use (0dB isn't high gain, it's no gain!) for
example.

--2+gS0LBHjVo9w9tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8DGUAAoJELSic+t+oim9KscP/1S6F/X0Mw2HsuOzDHIwOmGU
mk/f8MWtrwyhmpAzg4VyHqmIZM9u/5I8Sm4zHsj1if9iKisV980H6KnetzQSncZk
5dpIEfU4/RAaZh4av23QrqN8CWUPfla1s5MjSXKvcc05Y/eOzmMoF19I2ZuLs+UG
8C1FrWtZKMDStcH6Yn03RzH86cxTPxKXamRKLUdpULed2ZnJ4LcNGVdttBWPZDsd
uvHE4jjRz3lV8VH8q040dpTN/d8lggAsTPcndLE4iPuHf1rQVmJKcznGvP3+TReD
CXSPQKQ3o5i7tIMcJnmIvyKE9yq3cExgOddIqbkjh2oA4z8zv93+Bi8euRhZqfCj
UhQvPnMaxMWtKcHDp9468WkSZyQZ8T+b6yZti/tehxYALZr1rmPYk+qHic7JQR7v
CQ1uS1LmAKFO6NPiCo+ENHsyFupGs0l4ULvxVSb8jW79YcbFC1o4hvD77wVEObdA
fdD0oVcgLolMgrvO/Cks07auSRsu4aC7AnC8ZVSvRw3qJDCbqUMWoljs8N8dETm7
ygcxDqUMnCShGyuCplKH3ct3b6gkwbFUsr/2TzyblMx7YKDKaVfAdVetzokW7dgU
lmBPLdjfShxPImD3poOc78Vs0Qka0rNezJDtB/lXKmsUYHbYXUhNZY1su3vfgbna
s6sjQPiiBsjvPc1m1ijY
=gv4V
-----END PGP SIGNATURE-----

--2+gS0LBHjVo9w9tQ--

--===============6339557305200375280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6339557305200375280==--
