From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 09:54:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F12qv5jKxJdqDx0003d629@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (sea2-f12.sea2.hotmail.com [207.68.165.12])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA05975
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 09:54:59 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




>From: p z oooo <pzad@pobox.sk>
>Reply-To: p z oooo <pzad@pobox.sk>
>To: guanyim@hotmail.com
>Subject: Re: [Alsa-devel] Need to know SBLive Chip difference
>Date: Tue, 30 Mar 2004 08:37:35 +0200

>Right now I compared changes between alsa 1.0.3b  and 1.0.4rc1.
>Diffrence is that 1.0.4rc1 contains support for AC97 codec used in
>2003 SB Live (Sigmatel STAC9758) and I think, that make it not to
>working.
>
>Try to change line in alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c
>{ 0x83847658, 0xffffffff, "STAC9758/59", patch_sigmatel_stac9758,
>	NULL },
>
>to
>{ 0x83847658, 0xffffffff, "STAC9758/59", NULL,	NULL },
>
>Peter Zubaj
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>Java Desktop System predstavuje prvu pouzitelnu alternativu voci Windows=
 za
>poslednych 15 rokov, pretoze prinasa z=E1kaznikom bezpecne a doveryhodne
>desktopove riesenie za zlomok ceny Windows.
>Viac informacii najdete na : http://www.somi.sk/sun/java_desktop.php
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>

Ya thanks I get back the Front L/R and Center/Subwoofer output now.


>Hi,
>
>Personaly I don't think there is diffrence in emu10k1 between 2003 and=20
>2002. Diffrence is in AC97 codec. In 2002 is two channel. In 2003 is six=
=20
>channel. I looked for datasheet for this AC97 codec, but it is not publi=
c=20
>available. I think, that only some initialization is needed.
>
>Could you try OSS driver if it works ???
>
>Peter Zubaj
>

Trying oss thing to see if can get the Rear L/R. Btw, how could I get the=
=20
AC97 spec for this new codec, by subscription and pay some fee to some=20
organization? I wish I could help.

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*=20
http://join.msn.com/?page=3Dfeatures/virus



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
