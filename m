From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Mon, 27 Jan 2003 18:03:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301271759530.4643-100000@rzstud2.stud.uni-karlsruhe.de>
References: <Pine.LNX.4.44.0301271705540.1279-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301271705540.1279-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> > > > Broken configuration: no configurations available: Invalid argument
> > >
> > > doesn't it work with the pcm "plug:multi" ?
> >
> > Sorry, but I can't find any documentation on "plug:multi"?
> > How do I have to to use it?
>
> aplay -Dplug:multi
>
> It's device description/name for alsa-lib.

Thanks for that one, but

arecord -Dplug:multi -c16 multitest.wav
gives me

ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for
symbol _snd_pcm_plug:multi_open
ALSA lib pcm.c:1788:(snd_pcm_open_conf) symbol _snd_pcm_plug:multi_open is
not defined inside (null)
arecord: main:462: audio open error: No such device or address

Oli




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
