From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Problem compiling latest CVS with gcc-2.95.3
Date: Tue, 11 Mar 2003 15:30:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311143024.GA23079@tuba.home>
References: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr> <20030308091124.GA29733@tuba.home> <20030308094052.GB29733@tuba.home> <20030308224427.GA25823@tuba.home> <s5hu1ea2orw.wl@alsa2.suse.de> <20030311111254.GA16731@tuba.home> <s5hisuq2gzo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hisuq2gzo.wl@alsa2.suse.de>
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

On Tue, Mar 11, 2003 at 02:02:51PM +0100, Takashi Iwai wrote:
> > On Tue, Mar 11, 2003 at 11:14:43AM +0100, Takashi Iwai wrote:
> > > 
> > > IIRC, the -falign-xxx is a new option and the older compiler had
> > > -malign-xxx instead.  could you check the attached patch whether it
> > > works?
> 
> my patch works like 2.5 kernel does; checks whether -falign is
> accepted and use -malign if not.  so, it would be appreciated if you
> can check that before putting it to the cvs tree.
> 

No problems. That patch compiles fine using -malign. 
So, everything is ok.


martin


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
