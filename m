From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Register DSP1 Aux widgets
Date: Wed, 21 Nov 2012 10:32:24 +0900
Message-ID: <20121121013222.GF4673@opensource.wolfsonmicro.com>
References: <1353417321-4100-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6892470870397813113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24B5B261698
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 02:32:30 +0100 (CET)
In-Reply-To: <1353417321-4100-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6892470870397813113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 01:15:21PM +0000, Dimitris Papastamos wrote:
> It seems WM_ADSP2("DSP1", 0) is added twice to the widgets list, remove
> that and in place use ARIZONA_DSP_WIDGETS(DSP1, "DSP1").

Applied, thanks.

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrC8UAAoJELSic+t+oim9aPwP/37iq/r9FXP5ppI/ccyAdatd
iAqpsF0iQhmXUsfeXQy+X3/P04dF23E18sQJOVgXi6fSLXlokeWDVFT6pgwZTdYV
6NaO3T/L2fGtptRvFueAMC6oLAs5kPW1TXe/t+tcSAkuWK9mV5fX3CAXm5csrZ+g
L/bwbm8aNZE80S421EQPdMG8Zc99hv2EBJWi+TIwiu6SU0SGVd2dGhakJ7UuUXv/
LplDcdc0jVQCwJgiPewcEvUx/2xHII+lLV8LXSJ4iH8ExcOal+THLPDzA1UXYecQ
T25qK5JkE5vaTiNyaegxkSLXC5Qf+q8iG8dAtv3b2mx9o6jfnKPk0yGv63xQrmvi
5i3hhbwyPh+huVWUmaRezeMaGkVmPsDOSLN41wP+6VMs9DKRhVZfzYbQu9uLJrog
YUxIc5JhGtwrz8U84aj/lUxkYRfoigW07+AeFwrAXfI1/66Ii6z49eR8vBPcPyMG
IQs9qXGhg3DOxazQPVm0nRyVYqfnSgN2zqzt4VhzwEFW5ZPLBlMhR0ygTqLcAM/b
bU0NLxf0kmk2qyIAUjJaLs0BdHvy4INY1ey73V8FLTKa2vpeb+I6WcH/EwKcoaxi
mrLZb3lKxJ1KflfM5ga28TVI154R4dzXx9T5tqAHLc7VXXkpK7O/CGBucU8xo61o
OCUljEhD3lDsRRG0IIk+
=UxL1
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--

--===============6892470870397813113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6892470870397813113==--
