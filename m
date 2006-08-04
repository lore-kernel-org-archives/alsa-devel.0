From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-announce] ALSA 1.0.12rc2
Date: Fri, 04 Aug 2006 18:42:43 +0200
Message-ID: <m2zmeke9ks.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<m24pwsfoi3.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDC15134
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 18:42:43 +0200 (MEST)
In-Reply-To: <m24pwsfoi3.fsf@vador.mandriva.com> (Thierry Vignaud's message of
	"Fri, 04 Aug 2006 18:35:00 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud <tvignaud@mandriva.com> writes:

> > 	1.0.12rc2 ALSA packages (except tools and oss - no changes) were =

> > released. The list of changes can be obtained here:
> > =

> > 	http://www.alsa-project.org/changes/v1-0-12rc1--v1-0-12rc2.txt
> =

> it looks like alsa-firmware lacks some check in its configure.in...
> =

> make[1]: Entering directory `/tmp/tv-build/alsa-tools-1.0.12rc1/alsa-firm=
ware-1.0.12rc2/emu'
> if x86_64-mandriva-linux-gnu-gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=
=3D\"\" -DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPOR=
T=3D\"\" -DPACKAGE=3D\"alsa-firmware\" -DVERSION=3D\"1.0.12rc2\" -DSTDC_HEA=
DERS=3D1  -I. -I.     -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -=
MT fw_writer.o -MD -MP -MF ".deps/fw_writer.Tpo" -c -o fw_writer.o fw_write=
r.c; \
> then mv -f ".deps/fw_writer.Tpo" ".deps/fw_writer.Po"; else rm -f ".deps/=
fw_writer.Tpo"; exit 1; fi
> fw_writer.c:31:32: error: audio_dock_netlist.h: Aucun fichier ou r=E9pert=
oire de ce type
> fw_writer.c: In function 'main':
> fw_writer.c:56: error: 'audio_dock_netlist' undeclared (first use in this=
 function)
> fw_writer.c:56: error: (Each undeclared identifier is reported only once
> fw_writer.c:56: error: for each function it appears in.)
> make[1]: *** [fw_writer.o] Erreur 1
> make[1]: Leaving directory `/tmp/tv-build/alsa-tools-1.0.12rc1/alsa-firmw=
are-1.0.12rc2/emu'
> make: *** [all-recursive] Erreur 1

on second though, it looks like you did not pull/update all changes
for alsa-firmware... :-(

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
