From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: finally, ALSA 1.0.24 is out
Date: Mon, 7 Feb 2011 08:19:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102070817400.6272@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
	<AANLkTinW9nD4EAFPczAG47GGGKW4XEGx0BqSwLySR2v=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1796410586-1297063147=:6272"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D5742462B
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 08:19:08 +0100 (CET)
In-Reply-To: <AANLkTinW9nD4EAFPczAG47GGGKW4XEGx0BqSwLySR2v=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1796410586-1297063147=:6272
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Feb 2011, Raymond Yau wrote:

>=20
>=20
> 2011/1/31 Jaroslav Kysela <perex@perex.cz>
>       Hello all,
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0after very intensive testing, I released=
 all ALSA
>       packages with
>       version number 1.0.24(+) :
>

> when running alsa-driver 1.0.24 configure script
>=20
> ./configure --with-debug=3Dverbose
>=20
> why the script try to remove some system files ?
>=20
> checking for built-in ALSA... no
> checking for existing ALSA module... yes
> checking for Red Hat kernel... auto
> checking for Red Hat kernel... no
> checking for SUSE kernel... auto
> checking for SUSE kernel... no
> checking for updating alsa-kernel version.h... yes
> checking for CONFIG_EXPERIMENTAL... yes
> rm: cannot remove `include/linux/usb/audio-v2.h': Permission denied
> rm: cannot remove `include/linux/usb/audio.h': Permission denied
> rm: cannot remove `include/trace/events/asoc.h': Permission denied

There rm calls are for alsa-driver/include tree (for emulated headers).=20
You probably unpacked source with different permissions than you're=20
trying to compile.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1796410586-1297063147=:6272
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1796410586-1297063147=:6272--
