From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-utils from CVS
Date: Sun, 15 Jun 2003 12:21:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306151218300.2529-100000@pnote.perex-int.cz>
References: <20030615152210.21cd9d4a.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030615152210.21cd9d4a.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 15 Jun 2003, Erik de Castro Lopo wrote:

> On Sun, 15 Jun 2003 12:27:54 +1000
> Erik de Castro Lopo <erikd-alsa@mega-nerd.com> wrote:
> 
> > Hi all,
> > 
> > I have managed to download alsa-driver, alsa-kernel and als-lib from CVS but
> > I can't get alsa-utils. 
> > 
> >     erikd@coltrane > cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
> >     Logging in to :pserver:anonymous@cvs.sourceforge.net:2401/cvsroot/alsa
> >     CVS password: 
> >     erikd@coltrane > cvs co alsa-utils
> >     cvs server: cannot find module `alsa-utils' - ignored
> >     cvs [checkout aborted]: cannot expand modules
> > 
> > Has anybody else managed this?
> 
> It looks like SourceForge will not accept
> 
>     cvs co alsa-utils
> 
> but will accept:
> 
>     cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-utils
> 
> Its probably insisting that I use compression over the net.

'cvs login' only creates repository->password entries (in ~/.cvspass), so 
you have to specify the full repository address for checkout again, 
because CVS/* files does not exist at the moment (thus cvs does not know, 
which repository is root).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
