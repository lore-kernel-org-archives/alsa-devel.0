From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 01:06:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077754003.2680.26.camel@thor.asgaard.local>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from netline-mail1.netline.ch (netline-mail1.netline.ch [195.141.226.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA12377
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 01:06:56 +0100
In-Reply-To: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-02-21 at 23:05, Jaroslav Kysela wrote:=20
>=20
> 	I am trying to fix resampling problems in alsa-lib and OSS
> emulation problems in alsa-oss package. I released first preview of my
> changes. It would be nice, if you can test my changes and report me bug=
s
> or comments (especially to the new OSS redirector code).

Haven't gotten around to trying that yet, but alsa-oss no longer works
here (1.0.2 works):

> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
zsh: segmentation fault=20
LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so gdb bzflag
zsh: segmentation fault=20
LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so gdb bzflag
> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so catchsegv
bzflag
zsh: segmentation fault=20
LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so catchsegv
bzflag


How can I debug this?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI devel=
oper
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
