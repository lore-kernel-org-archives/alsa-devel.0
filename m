From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-announce] ALSA 1.0.12rc2
Date: Fri, 04 Aug 2006 19:11:33 +0200
Message-ID: <m2slkce88q.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<m24pwsfoi3.fsf@vador.mandriva.com> <s5h7j1otpmz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FD8E171
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 19:11:38 +0200 (MEST)
In-Reply-To: <s5h7j1otpmz.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
	04 Aug 2006 18:46:44 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > it looks like alsa-firmware lacks some check in its configure.in...
> > =

> > make[1]: Entering directory `/tmp/tv-build/alsa-tools-1.0.12rc1/alsa-fi=
rmware-1.0.12rc2/emu'
> > if x86_64-mandriva-linux-gnu-gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAM=
E=3D\"\" -DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPO=
RT=3D\"\" -DPACKAGE=3D\"alsa-firmware\" -DVERSION=3D\"1.0.12rc2\" -DSTDC_HE=
ADERS=3D1  -I. -I.     -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions =
-MT fw_writer.o -MD -MP -MF ".deps/fw_writer.Tpo" -c -o fw_writer.o fw_writ=
er.c; \
> > then mv -f ".deps/fw_writer.Tpo" ".deps/fw_writer.Po"; else rm -f ".dep=
s/fw_writer.Tpo"; exit 1; fi
> > fw_writer.c:31:32: error: audio_dock_netlist.h: Aucun fichier ou r=E9pe=
rtoire de ce type
> =

> Oops, it's missing in emu/Makefile.am.
> =

> I fixed it on HG.  Jaroslav, could you re-tag and re-package
> alsa-firmware?

as 1.0.12-rc2.1 preferrally for proper updates for distributors...
thanks

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
