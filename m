From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 17:32:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209171729270.505-100000@pnote.perex-int.cz>
References: <87u1kolow9.fsf@zaphod.blackdown.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87u1kolow9.fsf@zaphod.blackdown.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Tim Goetze <tim@quitte.de>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Sep 2002, Juergen Kreileder wrote:

> Tim Goetze <tim@quitte.de> writes:
> 
> > Florian Bomers wrote:
> > 
> >>Why does this happen ? I searched the mailing list archive and only
> >>found an explanation that symbols don't match and I need to
> >>recompile the ALSA lib. In my case it's a clean install of ALSA on a
> >>newly installed red hat system. There was never any other version of
> >>ALSA.
> > 
> > you probably are calling alsa from a shared object -- try 
> > 
> >   dlopen ("libasound.so", RTLD_LAZY | RTLD_GLOBAL);
> > 
> > in your module's init function.
> 
> The need for RTLD_GLOBAL is somewhat ugly, usually one wants to load
> plugins with RTLD_LOCAL.  E.g. Java's System.load()/loadLibrary()
> doesn't use RTLD_GLOBAL.  We could make a special case for ALSA in our
> Java implementation but that won't help people running JMF with
> another JVM.
> 
> Is there any reason ALSA can't do something like 
> 
>    if (name == NULL) {
>        Dl_info dlinfo;
>        static int dummy;
>        dladdr((void *) &dummy, &dlinfo);
>        name = dlinfo.dli_fname;
>    }
> 
> in snd_dlopen()?  This would fix the snd_dlopen(NULL, ...) problem
> when the ALSA library has been dlopened with RTLD_LOCAL and the
> symbols are unknown in the main program.

Nice fix. Applied.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
