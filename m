From: Nicola Orru' <nigu@itadinanta.it>
Subject: Re: emu10k1 module compile error with latest cvs
Date: Sat, 2 Aug 2003 16:04:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030802160424.03b022de.nigu@itadinanta.it>
References: <1059818056.5386.5.camel@gruuvi>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.bp0pg(ptsTXxP_"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1059818056.5386.5.camel@gruuvi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=.bp0pg(ptsTXxP_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 02 Aug 2003 12:54:16 +0300
Jaakko Prattala <Jaakko.Prattala@Helsinki.FI> wrote:

> gcc -D__KERNEL__ -DMODULE=1
> -I/home/jaakko/downloads/alsa020803/alsa-driver/include 
> -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
> -march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
> -DKBUILD_BASENAME=emufx   -c -o emufx.o emufx.c
> In file included from emufx.c:2:
> ../../alsa-kernel/pci/emu10k1/emufx.c: In function
> `snd_emu10k1_gpr_ctl_put':
> ../../alsa-kernel/pci/emu10k1/emufx.c:367:
> `EMU10K1_GRP_TRANSLATION_BASS' undeclared (first use in this function)

It looks like a typo. Try and open emufx.c and replace EMU10K1_GRP_* with EMU10k1_GPR_*.


-- 
Ciao,
Nicola
--------------------------------------------------------------------
* Nicola Orru' - Via Dei Tulipani, 9 - 09034 Assemini (CA) - ITALY *
--------------------------------------------------------------------

--=.bp0pg(ptsTXxP_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K8T1UZWo8oDibtERAj2hAJwP5OA8MzQl/sVkHJi22IqUEGhpQwCeK3SW
NUa0HgN/qotNNEE269NVUW4=
=bWrj
-----END PGP SIGNATURE-----

--=.bp0pg(ptsTXxP_--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
