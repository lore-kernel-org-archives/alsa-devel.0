From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: problems with unresolved symbols in 2.4.25 and intel8x0
Date: Mon, 15 Mar 2004 18:36:56 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040315183656.20948.qmail@web40605.mail.yahoo.com>
References: <200403151633.i2FGX5CL020642@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403151633.i2FGX5CL020642@sith.maoz.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Jeremy Hall <jhall@maoz.com> wrote: > Hello,
> 
> I just did a cvs update -dP on my CVS because I was
> experiencing lockups 
> when using intel8x0 and my drivers were a bit old.
> 
> When I had finished running ./cvscompile in
> alsa-driver, alsa-lib, and 
> alsa-tools along with appropriate make install's,
> this is the output I got 
> when trying to run modprobe snd-intel8x0

I strongly suspect that the following modules (at
least) have not been compiled:

snd.o
snd-timer.o
snd-virmidi.o
snd-mixer-oss.o

They don't get compiled on any of my systems either.
You could always try editing your "toplevel.config
file by hand, and then typing "make".

Cheers,
Chris



	
	
		
___________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
