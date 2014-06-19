From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5100/wm8903/wm8996: Replace
 open-coded snd_soc_dapm_to_codec()
Date: Thu, 19 Jun 2014 10:56:02 +0100
Message-ID: <20140619095602.GL5099@sirena.org.uk>
References: <1403157002-11638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3940949459902943352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60E462610CB
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 11:56:25 +0200 (CEST)
In-Reply-To: <1403157002-11638-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3940949459902943352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OjaoFelNtturnNY9"
Content-Disposition: inline


--OjaoFelNtturnNY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 07:50:01AM +0200, Lars-Peter Clausen wrote:
> We now have a generic helper function to cast from a DAPM context to a CODEC.
> Make use of it in the places which previously open-coded it.

Applied, thanks.

--OjaoFelNtturnNY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTorOvAAoJELSic+t+oim9L7EP/RTYGHAHBrzYQDnPrIAtmqPQ
5ZhAOwRQbdwl0tjj3/FyyRLSI5ROpi35pdrqePiKcPHwZQ2hHgXwZ2+p5hJm8NPE
ZRr/vGYTPX5S7hy6nRr+nSXKMj6u3v7657dcg6E9wpEEX7X3lFQehDEh/EPmLJMD
0TsxD5tPCJn6TYy8ASNthaY3Jr7cpwY7+e56MQhRIfuCZDk7oo3i1Ueh+jbmScAn
q2cWSkmEyITmmG8e+jzYixRsfzaUiPu9omFLi6hiA465h/ROh+3gID5uKQWyEZ55
1/bigOOmJacyuFSDMDF0NXofo2IwhkgjJE6+CwuQZT4/UV+7NKXhjEr+YwUijBuw
1KKgPIyc9G5WWv9N7sCJsqZuNPT7tG8hA1Pq1JVmF+UywhJPfELldOJD7XZA3kFx
5cTfMFv9jIWopWwwoB/wMXIC18/wpqS7Pe7SnUmj/n4d7+2RzcSiEFtvRzU6uSGp
rjCn8Mfsqk+EYCXZiAnyOrWZK9xsK3pLlZ2JRdZ7Zqe+m1fh/jJ0aHhJ9dTl3fFd
bmK7k2kEn0GmF++Eheh8hs1MNqa8iF2W8xh15/4TltSyumF0YjFPIBrxlGPrA0eD
/pHmqsBgL+8uxB7dHvmhQbKi/sYA14wStHtKt3LKQPeLEeRUMZq5NUjyiRrnS7WS
fWzc7LcIzg4QCk28NrVI
=Tu9h
-----END PGP SIGNATURE-----

--OjaoFelNtturnNY9--

--===============3940949459902943352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3940949459902943352==--
