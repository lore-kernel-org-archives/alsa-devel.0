From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: davinci-mcasp: Configure xxTDM,
 xxFMT and xxFMCT registers synchronously
Date: Fri, 31 Jan 2014 15:59:10 +0000
Message-ID: <20140131155910.GH22609@sirena.org.uk>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
 <1391087725-4088-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7562355567839726332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 695B3265011
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:59:16 +0100 (CET)
In-Reply-To: <1391087725-4088-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7562355567839726332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8uW5FuPCb1tAG9uS"
Content-Disposition: inline


--8uW5FuPCb1tAG9uS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:15:23PM +0200, Peter Ujfalusi wrote:
> These registers can be configured synchronously for playback and capture.
> Furthermore when McASP is in master and sync mode the capture operation
> needs the TX path to be configured in order to be able to provide the needed
> clocks for the bus.
> xxFMT and xxFMCT registers has been already configured for both TX and RX
> other places in the driver.

Applied, thanks.

--8uW5FuPCb1tAG9uS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68hKAAoJELSic+t+oim9i7MP+wXsbj5COheZmYFqSvTTDFay
IeXX/EA+U0PJb5SeXNzO/dDebidBXw8aezUcYHi0Hn3iTS4SaONpdJ530bbjf9rR
aHIvg7BPqPDozwm12QFPFL0azxS8nE99icfyTzlAsJ2Y54yqfMpPthPcDT81Z4aX
6BREutCSk8d1pVJlZtBJnBpFiuM+mRoZQiWYXUljKGgdwqfiZe2uchXddTEF6XE7
zn/AjxR11Vs3TC9S5FUwdcX3nwtm3fH5+9YDNszQUpN1WmVZdASqAMf1lyir9ynW
RuCn8uTgfQxMvrsNA4C+/WZqxABW/NSKL3KieHtTCUeL5atMnmYZuyPGJLFSN0q2
wXrShInU8t22nl8dk7Bbicdkn2rszLl9yykKtdlQo5fmWES/fisJ8h2H2JHGPILF
TeSFhxUix0gTM9dayQyz81MdZhv9zz0IxyJHFJIU0mzgGxYMXpjwB40gKSB2JKq1
ZnaB5egFDfW8GEK0Iy7neoAZS9ZW90U7lhvRg/TXw1itOHxyi7nPDuQYi4J2//uP
FbZJKGyeP+mBMIQbEvT3XXEV/EU4dWDO88ArDuLTJEi8kSAKMzCTDAd2j9Lk8A3n
OT/JzxCHA85jgiQOVw5ZblWEu/JQNE1yl8rfAuRwNPVo0DVtmDYcOBua0SlnjGmk
h6EEeRmqoCxO+nK4geGv
=Vg0I
-----END PGP SIGNATURE-----

--8uW5FuPCb1tAG9uS--

--===============7562355567839726332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7562355567839726332==--
