From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: Re: [Alsa-user] Request for test of powermac driver
Date: Mon, 20 May 2002 22:36:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CE95E36.A6122F19@folkwang-hochschule.de>
References: <s5hn0v15p95.wl@alsa2.suse.de> <20020520104117.7f18005a.mis@creazone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Michal Seta <mis@creazone.com>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michal Seta wrote:
> =

> Hi,
> =

> I'm having trouble compiling the new powermac driver:
> =

> gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=3D1 -I/home/mis/CVS/alsa-driver/=
include -I/usr/src/linux/include -O2 -D__powerpc__ -fsigned-char -fno-bui=
ltin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DLIN=
UX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAM=
E=3Dpowermac   -c -o powermac.o powermac.c
> ../alsa-kernel/ppc/powermac.c:40: warning: `snd_enable' defined but not=
 used
> gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=3D1 -I/home/mis/CVS/alsa-driver/=
include -I/usr/src/linux/include -O2 -D__powerpc__ -fsigned-char -fno-bui=
ltin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DLIN=
UX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAM=
E=3Dpmac   -c -o pmac.o pmac.c
> In file included from pmac.c:1:
> ../alsa-kernel/ppc/pmac.c: In function `snd_pmac_new':
> ../alsa-kernel/ppc/pmac.c:1353: structure has no member named `mode'
> make[1]: *** [pmac.o] Error 1
> make[1]: Leaving directory `/home/mis/CVS/alsa-driver/ppc'
> make: *** [compile] Error 1

that's a typo. change "mode" to "model".

j=F6rn

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
