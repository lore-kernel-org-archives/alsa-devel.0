From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Fri, 27 Feb 2004 14:49:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040227134941.GA25734@sunrise.pg.gda.pl>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz> <1077754003.2680.26.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz> <1077804788.27443.51.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz> <1077805803.2677.67.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz> <1077817984.2680.119.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261933560.13076@pnote.perex-int.cz> <1077885495.13385.32.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (root@sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA28706
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 14:49:49 +0100
Received: from sunrise.pg.gda.pl (localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i1RDnhk4010343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 14:49:44 +0100 (CET)
Received: (from atlka@localhost)
	by sunrise.pg.gda.pl (8.12.11/8.12.11/Submit) id i1RDngrS010342
	for alsa-devel@alsa-project.org; Fri, 27 Feb 2004 14:49:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1077885495.13385.32.camel@thor.asgaard.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 27, 2004 at 01:38:16PM +0100, Michel D=E4nzer wrote:
> ioctl(5, SNDCTL_DSP_SETFRAGMENT, 0x7ffff308[4000c])
>=20
> even with the attached patch, which used to be enough to get it working.
> Adam's ('small and cosmetic'??? :) patch doesn't help either.
with this patch I could use Quake3, java -jar JavaSoundDemo.jar,
RealPlayer, FlashPlayer under mozilla and java sounds in browser
simultaniously, and xmms too (non mmap mode), and of course ALSA native
apps which are using default redefined mixing plugin.

Bad news - some apps probably clear environment or discards LD_PRELOAD
so they try get to the hardware anyway even using open call.
I observed this with mpg321 and mplayer -ao oss option.
So is why I still propose mixing in kernel - besides filtering every
open, close, write, read and other important calls with LD_PRELOAD
approach means slowdown of apps and potential security risk.
Someone could change preloaded lib to some sniffing/filtering worm.
So generally using LD_PRELOAD should be discarded.
Some of apps are closed source so we just couldn't rewrite them
with AOSS stub code or port to ALSA api.=20
So kernel is the only sensible solution IMHO ;-).

Back to bzflag. I will be investigating that. I think that something
is still broken in parameters refining. So theoretically you could
set sound parameters in any order and time, but it isn't quite true.
In some cases refining process returns error while in case of another
order of setting sound parameters all is ok.
I mean that it should be tested on more OSS apps because different
order of emulated OSS ioctls may product different behaviour.

PS.
	mpg321 is not working anyway because I have Intel codec fixed
to 48kHz and it wants DMA mode and 44100Hz (rate plugin in OSS emulation
doesn't supports this).

Regards
--=20
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
