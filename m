From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive exception
 handling
Date: Tue, 3 Dec 2013 20:18:28 +0000
Message-ID: <20131203201828.GC29268@sirena.org.uk>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131203182256.GL27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5146515366578972262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DF322652D3
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 21:18:32 +0100 (CET)
In-Reply-To: <20131203182256.GL27568@sirena.org.uk>
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
Cc: vinod.koul@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5146515366578972262==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 06:22:56PM +0000, Mark Brown wrote:

> You can't safely do most of this such as calling fclose() from within a
> signal handler, the set of functions that are guaranteed safe is quite
> limited - see signal(7).

I should also have mentioned that it looks like you're probably looking
for setvbuf() with _IONBF.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnjyRAAoJELSic+t+oim9q9MP/RS7+aEuqCyi7iQE/uPb/HJQ
FDRTPLgy+Hz1e4qvLI1slFUstEM7fHahkmm9PmkfNUK5POrDn5ezzNf88gPFZY/j
xhFhEDReNDsAp0ZwY3kLmvRzDUNV7n+nfDnnDfTB8MTiq3Sfa+B1CpZB8dnA1GID
ritqx49trumVj2W3efVr3CDBwN+aJtZXgMYu5923OBLXwDzC8aSjXuZ9P8mo44Si
E53gEDECm8beHqfOp8I2o8RlF0A6iM2qkeCfiT17xVRH/mdY17SYVnpzUa9mdk9k
2ujEZ7dAsY3dF31gahfI4wMQ0lFgX/HRDPnkJgekJvBdvVpNhXhky1ZstTl/eaht
EqAuDt/OTeeQhpLmMY+zooclThhX+NLJ8zuXgGrEVey0hoTGaE+81Y92HaNlzKDd
WYueZ3XhhP9JT0DF8lT+aaoq9Z23DV41M8+dg/QPEWd8Vr9uK0XvJYIlTIMaOgoC
zSxG3DjHT3TAkG1tDOVDdpp8jFT86JTNIvX7vwvpUAiHRYGow6lF3L2daUJDiV4C
yUCk0tBzKgDm490trgVLugQMTT92PJywueVhBZCoxKnaCUXrfbQkJKCkfG9phPtj
jSYhnEJBnHoLa4c12v6SbIXV7Kws1mbV871OuIUWERKN4eckQqVoEAvNY646sDDO
WwR9wmz2LSZ34Ta9ZS2j
=HpSl
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

--===============5146515366578972262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5146515366578972262==--
