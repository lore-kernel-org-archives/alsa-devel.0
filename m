From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 11:30:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
 <1077754003.2680.26.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA24898
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 11:35:11 +0100
In-Reply-To: <1077754003.2680.26.camel@thor.asgaard.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Feb 2004, Michel D=E4nzer wrote:

> On Sat, 2004-02-21 at 23:05, Jaroslav Kysela wrote:=20
> >=20
> > =09I am trying to fix resampling problems in alsa-lib and OSS
> > emulation problems in alsa-oss package. I released first preview of my
> > changes. It would be nice, if you can test my changes and report me bug=
s
> > or comments (especially to the new OSS redirector code).
>=20
> Haven't gotten around to trying that yet, but alsa-oss no longer works
> here (1.0.2 works):
>=20
> > LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
> zsh: segmentation fault=20
> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so bzflag
> > LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so gdb bzflag
> zsh: segmentation fault=20
> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so gdb bzflag
> > LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so catchsegv
> bzflag
> zsh: segmentation fault=20
> LD_PRELOAD=3D~/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so catchsegv
> bzflag
>=20
>=20
> How can I debug this?

Define this:

export ALSA_OSS_DEBUG=3D1

and run the application again.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
