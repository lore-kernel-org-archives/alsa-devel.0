From: Jeremy Hall <jhall@maoz.com>
Subject: Re: problems with unresolved symbols in 2.4.25 and intel8x0
Date: Mon, 15 Mar 2004 14:05:42 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403151905.i2FJ5gbJ021517@sith.maoz.com>
References: <20040315183656.20948.qmail@web40605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040315183656.20948.qmail@web40605.mail.yahoo.com> from Chris
 Rankin at "Mar 15, 2004 06:36:56 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: Jeremy Hall <jhall@maoz.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

yes this helped, modules are working fine.  I still get segv/core when I 
run alsactl store

_J

In the new year, Chris Rankin wrote:
>  --- Jeremy Hall <jhall@maoz.com> wrote: > Hello,
> > 
> > I just did a cvs update -dP on my CVS because I was
> > experiencing lockups 
> > when using intel8x0 and my drivers were a bit old.
> > 
> > When I had finished running ./cvscompile in
> > alsa-driver, alsa-lib, and 
> > alsa-tools along with appropriate make install's,
> > this is the output I got 
> > when trying to run modprobe snd-intel8x0
> 
> I strongly suspect that the following modules (at
> least) have not been compiled:
> 
> snd.o
> snd-timer.o
> snd-virmidi.o
> snd-mixer-oss.o
> 
> They don't get compiled on any of my systems either.
> You could always try editing your "toplevel.config
> file by hand, and then typing "make".
> 
> Cheers,
> Chris
> 
> 
> 
> 	
> 	
> 		
> ___________________________________________________________
> Yahoo! Messenger - Communicate instantly..."Ping" 
> your friends today! Download Messenger Now 
> http://uk.messenger.yahoo.com/download/index.html
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
