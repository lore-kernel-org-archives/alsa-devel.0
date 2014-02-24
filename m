From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Mon, 24 Feb 2014 10:29:46 +0900
Message-ID: <20140224012946.GR25940@sirena.org.uk>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
 <s5hr47gv1yi.wl%tiwai@suse.de>
 <20140206130735.GP32298@sirena.org.uk>
 <s5hwqgsy8b4.wl%tiwai@suse.de>
 <20140223030755.GW25940@sirena.org.uk>
 <s5hr46ufczx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6884238728092482982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8480D2652E5
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:34:43 +0100 (CET)
In-Reply-To: <s5hr46ufczx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Florian Meier <florian.meier@koalo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6884238728092482982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KHxoa/2yf2SjDQvg"
Content-Disposition: inline


--KHxoa/2yf2SjDQvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2014 at 09:29:38AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Feb 18, 2014 at 12:22:23PM +0100, Takashi Iwai wrote:

> > > There are still open issues after this, and let's discuss in another
> > > thread.

> > What were these?

> The strange usages of SOC_VALUE_ENUM in a couple of cirrus codec
> drivers.

Right, OK - there's also some volume controls are a bit odd there in
some of the older ones, seems a few things only worked by luck.

--KHxoa/2yf2SjDQvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCqCHAAoJELSic+t+oim9ikUP/0uCd7rmT2Qdg2sCwHpWGI6d
iDbsm2aaQEbTa6W+G8qfNcPI1JtvvMqtzzac6Rl2pT+eow/RQufKFYFO11jznenr
U0fik3n9dLox5Gk5a8w8Ar8b7rP5pATU5Dv2YiubgmpNrT5O1eQZRJ1wYzrBErpw
oG06Kvskh0HG3iBzu5ei3TjwTZ8YhsyEKxNFjqPjMTpW7ksWZO1ES1PFW8tUjBC3
Zvu3W9+xLWiuThzS+eg2VtkQKt6ZvlJkDSXhif9NJeQr4CnWdcHJzxv+jnDpEGyJ
7/Ql45psg6UoANEA0+i8YEISHZngXupvfN2yp7Avho5lBArjt19/o8F3ZORYm3fn
wYp/uNJlTw6d4zp9wtrI7ZHjwrOvJQNfcLwFjIwWbLkd/aYhHFiCFbOOjQszyzI5
/8RBCn8Sw1weICrnAN0WfcDLrrIeqkHNcirP/t1G0vbPW1Nek1Av104EgQWQXT+e
VstrxWuS0GproeHpms8ruvJ76dB70YBwSSqDU7whYFZ14KId0A1C4Le6/cQdXYCe
TpJpFnvkFFUDmGUSJdOSAM0yjlg4eJZu7ZFDl8HSoYA8uESiaV2npiuvXCNSQ6ul
FIZa8qKA3yj1O09psbO3kz3u4KJlYv1Yg1fn+sKZXmHCkRhgDXMbXvzPgBCkLWX+
zYo9uwzP9xXre9FHONL+
=PB87
-----END PGP SIGNATURE-----

--KHxoa/2yf2SjDQvg--

--===============6884238728092482982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6884238728092482982==--
