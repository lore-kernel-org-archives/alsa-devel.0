From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Problem compiling latest CVS with gcc-2.95.3
Date: Tue, 11 Mar 2003 12:12:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311111254.GA16731@tuba.home>
References: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr> <20030308091124.GA29733@tuba.home> <20030308094052.GB29733@tuba.home> <20030308224427.GA25823@tuba.home> <s5hu1ea2orw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu1ea2orw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: papadako@csd.uoc.gr, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2003 at 11:14:43AM +0100, Takashi Iwai wrote:
> At Sat, 8 Mar 2003 23:44:27 +0100,
> Martin Langer wrote:
> > 
> > On Sat, Mar 08, 2003 at 10:40:52AM +0100, Martin Langer wrote:
> > > On Sat, Mar 08, 2003 at 10:11:24AM +0100, Martin Langer wrote:
> > > > On Sat, Mar 08, 2003 at 10:51:29AM +0200, Panagiotis Papadakos wrote:
> > > >
> > > > > cc1: Invalid option `-falign-functions=4'
> > 
> > 
> > Removing that option really helps in my case. Don't know if it should be
> > really applied to the CVS tree.
> 
> IIRC, the -falign-xxx is a new option and the older compiler had
> -malign-xxx instead.  could you check the attached patch whether it
> works?
> 

ATM I'm using CVS without any patch again. It compiles fine. I haven't made
anything except an update of the CVS tree. This patch is no longer necessary
in my case.
I think it was fixed by Jaroslav from version 1.145 to 1.146 of configure.

I'm ready for .9 stable!

martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
