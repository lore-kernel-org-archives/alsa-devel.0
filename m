From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: snd_ prefix for module options
Date: Tue, 08 Oct 2002 17:48:33 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA37CE1.760C32F5@sun.com>
References: <s5hfzvh2fid.wl@alsa2.suse.de> <3DA33394.A7C5D9AE@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry guys, I thought you were talking about the snd_ prefix of the module NAMES
:) for the option names, dropping seems the right thing to do - an error message
should be printed when a snd_* option is used.

Florian


Florian Bomers wrote:
> 
> I like it a lot. Due to the prefix I was able to cleanly remove 0.5.x from my
> system, and we might want to do that later on with 0.9, too :)
> 
> And since I don't see any benefit in removing the prefix - other than cosmetic -
> keeping it will save time for distribution's programmers, sysadmins, writers,
> etc. to update their setup routines, configs, howtos, etc. :)
> 
> Florian
> 
> Takashi Iwai wrote:
> >
> > Hi,
> >
> > so far, all alsa modules use snd_ prefix for each module option.
> > iirc, there was a problem regarding namespace at the time of 2.0
> > kernel, and this was some workaround to avoid confliction.
> > but 2.2 and later kernels have no such a problem at all.
> >
> > so, i'd like to ask you how do you think to remove this snd_ prefix.
> > of course, there is one and only big problem - compatibility!
> >
> > the questions are
> >
> > - whether we should really do it or not?  is it worthy?
> >
> > and
> >
> > - when? now or after 0.9.0-final release?
> >
> > opinions, please?
> >
> > Takashi
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> --
> Florian Bomers
> Java Sound
> Java Software/Sun Microsystems, Inc.
> http://java.sun.com/products/java-media/sound/
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
