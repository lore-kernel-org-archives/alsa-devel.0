From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-announce] ALSA 1.0.12rc2
Date: Fri, 4 Aug 2006 19:19:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0608041918120.9118@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<m24pwsfoi3.fsf@vador.mandriva.com> <s5h7j1otpmz.wl%tiwai@suse.de>
	<m2slkce88q.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463789724-1770691048-1154711968=:9118"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 819E6140
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 19:19:29 +0200 (MEST)
In-Reply-To: <m2slkce88q.fsf@vador.mandriva.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463789724-1770691048-1154711968=:9118
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

yOn Fri, 4 Aug 2006, Thierry Vignaud wrote:

> Takashi Iwai <tiwai@suse.de> writes:
>=20
> > > it looks like alsa-firmware lacks some check in its configure.in...
> > >=20
> > > make[1]: Entering directory `/tmp/tv-build/alsa-tools-1.0.12rc1/alsa-=
firmware-1.0.12rc2/emu'
> > > if x86_64-mandriva-linux-gnu-gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARN=
AME=3D\"\" -DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGRE=
PORT=3D\"\" -DPACKAGE=3D\"alsa-firmware\" -DVERSION=3D\"1.0.12rc2\" -DSTDC_=
HEADERS=3D1  -I. -I.     -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=3D2 -fexception=
s -MT fw_writer.o -MD -MP -MF ".deps/fw_writer.Tpo" -c -o fw_writer.o fw_wr=
iter.c; \
> > > then mv -f ".deps/fw_writer.Tpo" ".deps/fw_writer.Po"; else rm -f ".d=
eps/fw_writer.Tpo"; exit 1; fi
> > > fw_writer.c:31:32: error: audio_dock_netlist.h: Aucun fichier ou r=E9=
pertoire de ce type
> >=20
> > Oops, it's missing in emu/Makefile.am.
> >=20
> > I fixed it on HG.  Jaroslav, could you re-tag and re-package
> > alsa-firmware?
>=20
> as 1.0.12-rc2.1 preferrally for proper updates for distributors...

We use 1.0.12rc2a naming scheme. I'll do new package.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
---1463789724-1770691048-1154711968=:9118
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---1463789724-1770691048-1154711968=:9118
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

---1463789724-1770691048-1154711968=:9118--
