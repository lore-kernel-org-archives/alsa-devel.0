From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: Re: make install for alsa-lib 0.9.1
Date: Thu, 13 Mar 2003 14:34:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303131431480.16757-100000@snylter.ii.uib.no>
References: <s5h1y1bwgqw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y1bwgqw.wl@alsa2.suse.de>
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

On Thu, 13 Mar 2003, Takashi Iwai wrote:

> At Thu, 13 Mar 2003 13:26:33 +0100 (CET),
> Ronny V. Vindenes <s864@lstud.ii.uib.no> wrote:
> > 
> > On 13 Mar 2003, Immanuel Litzroth wrote:
> > 
> > > 
> > > I use stow for package management and I noticed that 
> > > ./configure --prefix=/usr
> > > make 
> > > make install prefix=/usr/stow/alsa-lib
> > > still installs the libraries in /usr/lib. Previous versions worked
> > > installed in the correct place. Is this a bug?
> > > Immanuel
> > > 
> > 
> > IMHO it's a bug.
> 
> no, you need to specify exec_prefix, too.
> 
> 	% make install prefix=/xxx exec_prefix=/xxx
> 

Yes, of course. hehe I'll go eat my lunch and recharge the old brain now

-- 
Ronny V. Vindenes <sublett@dc-s.com>



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
