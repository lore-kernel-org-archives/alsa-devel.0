From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 19:38:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402261933560.13076@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
 <1077754003.2680.26.camel@thor.asgaard.local>  <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
  <1077804788.27443.51.camel@thor.asgaard.local>
 <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz>
 <1077805803.2677.67.camel@thor.asgaard.local>  <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz>
 <1077817984.2680.119.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA03757
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 19:43:33 +0100
In-Reply-To: <1077817984.2680.119.camel@thor.asgaard.local>
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

> On Thu, 2004-02-26 at 15:33, Jaroslav Kysela wrote:
> >=20
> > It looks that the wrapper code does not work as expected.
> > Can you add a printf calls to all public functions in=20
> > the alsa-oss/alsa/alsa-oss.c code, so we can determine
> > where the code hangs?
>=20
> The problem occurs when the ALSA_OSS_WRAPPER environment variable isn't
> set. initialize() returns early, so the public functions segfault when
> they try to dereference the uninitialized fds.
>=20
> Is there a reason why ALSA_OSS_WRAPPER must be set? Even if so, I think
> it should cope more gracefully otherwise. :)

No reason. I ommited to remove this hack when I separated the wrapper=20
code from the API emulation code. You can remove the lines without any=20
side effect. I also found next problems in the emulation code, so
I will release rc3 of alsa-oss package.

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
