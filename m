From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: gcc 3.x build issue? (was: cat /proc/asound/version: "No such device": HELP!!)
Date: Tue, 18 Feb 2003 19:49:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030218184924.GA2896@rhlx01.fht-esslingen.de>
References: <20030214111459.GA19210@rhlx01.fht-esslingen.de> <3E512D55.1030002@tin.it> <20030217191113.GA1853@rhlx01.fht-esslingen.de> <s5hn0kugeca.wl@alsa2.suse.de> <20030218155623.GA11912@nubol.int.oskuro.net>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030218155623.GA11912@nubol.int.oskuro.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 18, 2003 at 04:56:23PM +0100, Jordi Mallach wrote:
> On Tue, Feb 18, 2003 at 09:52:53AM +0100, Takashi Iwai wrote:
> > are you sure both all kernel sources and alsa drivers are compiled
> > with the same compiler?
> > you cannot mix gcc-2.x and gcc-3.x binaries for kernel.  the
> > combination likely causes oops.
> 
> Yes, this is what causes their problem. We've had oodles of reports
> regarding this, as people were still using kernel images generated
> before the gcc switch.
> 
> People, just recompile your kernel using gcc 3.2.
Indeed, that's what fixed it.
I'm sorry to hear that it's been coming up tons of times already.
But I had searched for cat /proc/* (or in fact asound/version):
"No such device" and hadn't found anything, so I'd decided to ask.
Anyway, a final Thank You for the very informative discussion!

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
Tel. +49 7159 800604                http://mohr.de.tt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
