From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emufxtool, formerly ld10k1
Date: Wed, 30 Jul 2003 21:10:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307302054090.9821-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0307302045290.9821-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307302045290.9821-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Nicola Orru' <nigu@itadinanta.it>, pzmt@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Jul 2003, Jaroslav Kysela wrote:

> On Wed, 30 Jul 2003, Takashi Iwai wrote:
> 
> > At Wed, 30 Jul 2003 20:04:08 +0200,
> > Nicola Orru' wrote:
> > > 
> > > > > May I have a pointer to a page (I'll RTFM!) that contains the
> > > > > "protocol" to apply when working on alsa cvs, to create, pack and
> > > > > send patches to maintainers? 
> > > >  
> > > > yes, documentation is always nice :)
> > > 
> > > Humm. I'm Sorry :(
> > > 
> > > I suppose I did not express myself clearly  :P. 
> > > 
> > > I don't know how to access that information, I would like to get it in some way. In a word: can you send me a link to the docs?
> > 
> > oh, sorry, i misread the sentence above.
> > 
> > well, there is no protocol for that.
> > so far, cvs write access is limited to ALSA core developers.
> 
> If I understand correctly, is emufxtool an extended version of ld10k1 
> (http://ld10k1.sf.net)?

Replying to myself: No, it is not.

Takashi, I suggest to postpone the integration of the emufxtool to 
alsa-tools. We have a bit duplicated work. But I think that ld10k1 code 
(linker side) from Peter Zubaj is better. He followed my directions and 
used the client/server mechanism. So linker can accept the DSP code from 
more different applications (resp. DSP code compilers or other 
generators) while maintaining the static image in the DSP instruction RAM.

If it is possible, can you guys settle details about linker communication
(and probably finish it)? We can integrate both projects then.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
