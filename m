From: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Re: Problem compiling latest CVS with gcc-2.95.3
Date: Tue, 11 Mar 2003 16:14:04 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0303111613170.22650@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr>
 <20030308091124.GA29733@tuba.home> <20030308094052.GB29733@tuba.home>
 <20030308224427.GA25823@tuba.home> <s5hu1ea2orw.wl@alsa2.suse.de>
 <20030311111254.GA16731@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030311111254.GA16731@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I works for me too...

	Panagiotis Papadakos

On Tue, 11 Mar 2003, Martin Langer wrote:

> On Tue, Mar 11, 2003 at 11:14:43AM +0100, Takashi Iwai wrote:
> > At Sat, 8 Mar 2003 23:44:27 +0100,
> > Martin Langer wrote:
> > >
> > > On Sat, Mar 08, 2003 at 10:40:52AM +0100, Martin Langer wrote:
> > > > On Sat, Mar 08, 2003 at 10:11:24AM +0100, Martin Langer wrote:
> > > > > On Sat, Mar 08, 2003 at 10:51:29AM +0200, Panagiotis Papadakos wrote:
> > > > >
> > > > > > cc1: Invalid option `-falign-functions=4'
> > >
> > >
> > > Removing that option really helps in my case. Don't know if it should be
> > > really applied to the CVS tree.
> >
> > IIRC, the -falign-xxx is a new option and the older compiler had
> > -malign-xxx instead.  could you check the attached patch whether it
> > works?
> >
>
> ATM I'm using CVS without any patch again. It compiles fine. I haven't made
> anything except an update of the CVS tree. This patch is no longer necessary
> in my case.
> I think it was fixed by Jaroslav from version 1.145 to 1.146 of configure.
>
> I'm ready for .9 stable!
>
> martin
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
