From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 15:13:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077804788.27443.51.camel@thor.asgaard.local>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
	 <1077754003.2680.26.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from netline-mail1.netline.ch (netline-mail1.netline.ch [195.141.226.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA29581
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 15:13:20 +0100
In-Reply-To: <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
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

On Thu, 2004-02-26 at 11:30, Jaroslav Kysela wrote:
> On Thu, 26 Feb 2004, Michel D=C3=A4nzer wrote:
>=20
> > > LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
> > zsh: segmentation fault=20

[...]

> > How can I debug this?
>=20
> Define this:
>=20
> export ALSA_OSS_DEBUG=3D1
>=20
> and run the application again.

No more information unfortunately:

> ALSA_OSS_DEBUG=3D1
LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
zsh: segmentation fault  ALSA_OSS_DEBUG=3D1
LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so

This is on PPC, could it be an endianness or similar portability
problem?


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
