From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device
	Tree support
Date: Tue, 5 Feb 2013 15:23:45 +0000
Message-ID: <20130205152344.GE4720@opensource.wolfsonmicro.com>
References: <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <20130131013500.GA4759@opensource.wolfsonmicro.com>
 <510AA551.30400@wwwdotorg.org>
 <20130131171158.GA15376@opensource.wolfsonmicro.com>
 <510AA720.9000904@wwwdotorg.org>
 <20130131172150.GC15376@opensource.wolfsonmicro.com>
 <87fw1g7q8g.wl%kuninori.morimoto.gx@renesas.com>
 <511034F5.3070809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842838136300170143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FB9D2615D1
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 16:23:46 +0100 (CET)
In-Reply-To: <511034F5.3070809@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1842838136300170143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jk/5KjyVsvxWSMIA"
Content-Disposition: inline


--jk/5KjyVsvxWSMIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2013 at 03:23:49PM -0700, Stephen Warren wrote:

> It seems extremely odd to me that the data delay would just happen to
> end up meaning that inverting the clock works out to magically make
> everything work.

> Still, if there really is a use-case for this in otherwise simple audio
> systems, then I guess specifying all the DAI properties in sub-nodes is
> indeed to simplest/most-flexible way to go.

I've heard of this before when things get routed through an inverter for
buffering (or sometimes a FPGA for something more fancy).

--jk/5KjyVsvxWSMIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRESPsAAoJELSic+t+oim9gJQP/iNARiAqqyh5AT0X+bPPAomF
2pkmZN86eFhm01qjK9QBONAmISkHFqbwQv2TwUY0ZQ53m+bZFsb9baU53j9Nk7+M
AgJcsYROcwkp/13wHoURL4bvk6zPBqSn/W/4y5c35RS0nJvZZ8JpuU4iVRvngetB
wCn53P5EFLpYWvWsEFMtzPOKOI0IutgvCbdbTa+WlXUlnSsgJDxLSaTOlBPHCI3y
3wSJXxl8dGYKlm9opG4PpGaTo7KwStHZzKKmsWnWV081lfwybvI6Ms6LSDCFXkPL
utpV5xb91/Z6TcS9whVTIRi06C5BFg2dlSY3ZQEcPWqvkSEbVAKat6XUqkdCfgbS
6w19ro3TItW9EXS5eyahdPOfTYMULButBdNlfkW10Oe4LrNA88/e6BMT/DpA1GEm
ThhCtQRaGH9kCMuyc8Iufkak0VWlKzs1fCa/Tq2j/EG22wlNaWcmIJL0XtGCqpfg
6QCVWAwx2YQaceT5z8aqZKuQoxMPdnd8urExPVmRWSgbqohE93TFvlZGNXmfRowG
KODNmrCIEDGjPUyA7cG6LRYadllrL3kxCZwJLe2gAWUMqrmjvTkbI+JiMVcJXaMV
p7Rp9R+fsPX02+oBH8pVzmCiqHLTlTqu2tMvBH/kPZtme9LxORMmxyHFAvFUE0s9
6jg2m6gSG3+XLhy6Y+iF
=iVKv
-----END PGP SIGNATURE-----

--jk/5KjyVsvxWSMIA--

--===============1842838136300170143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1842838136300170143==--
