From: Richard Lemon <richard@clinicdesign.com.au>
Subject: Re: nforce2 (snd_intel8x0) channels scrolling
Date: 14 Nov 2003 10:54:21 +1030
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1068769461.2826.1.camel@baked.spud.com>
References: <ACB58D7EB1318947B319C01D1A5C38634B6B3E@neo.spud.com>
	<3FB020B1.4090406@superbug.demon.co.uk>
	<20031113181846.7d9b5d83.uvi@ezmail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031113181846.7d9b5d83.uvi@ezmail.ru>
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

Hi Vladimir,

I have written a small program to show the channel scrolling problem on
the nforce 2 chipset. 

James tested it on his system and the problem did not occur. I tested it
on an Intel/Analog devices system the problem does not occur. It is
specific to the nforce2 chipset. 

I was wrong when I said it occurred on the intel system (There is
another problem I am tracking down in my code which does occur on both).

I am going to try to track down and fix the problem, but I have a fair
bit of learning to do before I will be able to figure it out.

Richard.

On Fri, 2003-11-14 at 01:48, Vladimir I. Umnov wrote:
> On Mon, 10 Nov 2003 23:35:13 +0000
> James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
> > Richard Lemon wrote:
> > > Hi All,
> > > 
> > > This is one of the problems I have been seeing with the intel8x0
> > > driver as well. The problem occurs when you call snd_pcm_start a
> > > second time after an xrun, or after you have shut down a program
> > > with ctl-c and started it again in the same console. I used the 
> > > 
> > > If you close the console and open a new one the problem seems to go
> > > away!? I used the example code pcm.c from the alsa-lib test
> > > directory.
> > > 
> > > It occurs with both [nforce2 ALC650] combo and [Intel 82901EB-ICH5
> > > Analog devices id 75].
> > > 
> > > I also have a problem when the drivers have been running for a long
> > > time (around 5 hours). Without an xrun the snd_pcm_delay() function
> > > starts returning impossible numbers. Checking drift against either
> > > rdtsc or gettimeofday() alsa starts giving me a 0.1 second per
> > > second drift.
> > > 
> > > I haven't got a machine I can set up for this style of kernel
> > > debugging unfortunately, so I am trying to code around these
> > > problems.
> > > 
> > > richard.
> > > 
> > > 
> > Would you be able to submit a small self contained (like the 
> > speaker-test code I submitted) source code that would reproduce the 
> > problem quickly.
> > I would expect that writing code to force xruns would be quite easy.
> > I have a ICH5 with ALC650 chip on Motherboard here, so I might be able
> > to help you out if I could reproduce your problem.
> try to open/close (without seeking) in mplayer or xine - always scrolls
> to next position (i think 3 positions at all).
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: ApacheCon 2003,
> 16-19 November in Las Vegas. Learn firsthand the latest
> developments in Apache, PHP, Perl, XML, Java, MySQL,
> WebDAV, and more! http://www.apachecon.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
