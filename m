From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: management of codes (linux 2.5 inclusion)
Date: Fri, 15 Feb 2002 00:11:32 +0100
Message-ID: <20020215001132.B1381@idefix.fvdpol.home.nl>
References: <s5hheok3urf.wl@alsa2.suse.de> <Pine.LNX.4.31.0202141726520.510-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0202141726520.510-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi Jaroslav,

I suppose keeping the ALSA CVS as our root would indeed be the best option.
Synchronisation of the kernel and our CVS tree could be sort of a challenge
since people wil start to submit patches against the kernel tree (and
possibly only posted to lkml). 

On the other hand the diff between CVS and kernel tree should not grow too
big, since in that case Linus would start to dislike our patches (as
happened with the isdn guys). Frequent synchronisation wil be important,
which as a downside involves a lot of bookkeeping which patches have been
applied by Linus, and which not (yet).

Just some thoughts,
Frank.


ps: the ALSA merge in the kernel was indeed a great milestone, and I must
admit I used it as a good excuse for giving a small party :-)



On Thu, Feb 14, 2002 at 05:34:37PM +0100, Jaroslav Kysela wrote:
> On Thu, 14 Feb 2002, Takashi Iwai wrote:
> 
> > now a realistic question:
> >
> > how do we manage the alsa driver codes together with linux 2.5 tree?
> > will be like before, i.e. occasionally Jaroslav sends patches to Linus
> > (or directly to bk) based on the alsa cvs?
> 
> Yes, I would like to leave the ALSA's CVS repository as root of our
> sources. I think that syncing should be done for each new Linux releases.
> I take care about it, next days proves my plans.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
