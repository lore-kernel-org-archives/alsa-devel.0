From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 18:53:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077817984.2680.119.camel@thor.asgaard.local>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
	 <1077754003.2680.26.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
	 <1077804788.27443.51.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz>
	 <1077805803.2677.67.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from netline-mail1.netline.ch (netline-mail1.netline.ch [195.141.226.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA02560
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 18:53:14 +0100
In-Reply-To: <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz>
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

On Thu, 2004-02-26 at 15:33, Jaroslav Kysela wrote:
>=20
> It looks that the wrapper code does not work as expected.
> Can you add a printf calls to all public functions in=20
> the alsa-oss/alsa/alsa-oss.c code, so we can determine
> where the code hangs?

The problem occurs when the ALSA_OSS_WRAPPER environment variable isn't
set. initialize() returns early, so the public functions segfault when
they try to dereference the uninitialized fds.

Is there a reason why ALSA_OSS_WRAPPER must be set? Even if so, I think
it should cope more gracefully otherwise. :)


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
