From: "Vladimir I. Umnov" <uvi@ezmail.ru>
Subject: Re: nforce2 (snd_intel8x0) channels scrolling
Date: Thu, 13 Nov 2003 18:18:46 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031113181846.7d9b5d83.uvi@ezmail.ru>
References: <ACB58D7EB1318947B319C01D1A5C38634B6B3E@neo.spud.com>
	<3FB020B1.4090406@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FB020B1.4090406@superbug.demon.co.uk>
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

On Mon, 10 Nov 2003 23:35:13 +0000
James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> Richard Lemon wrote:
> > Hi All,
> > 
> > This is one of the problems I have been seeing with the intel8x0
> > driver as well. The problem occurs when you call snd_pcm_start a
> > second time after an xrun, or after you have shut down a program
> > with ctl-c and started it again in the same console. I used the 
> > 
> > If you close the console and open a new one the problem seems to go
> > away!? I used the example code pcm.c from the alsa-lib test
> > directory.
> > 
> > It occurs with both [nforce2 ALC650] combo and [Intel 82901EB-ICH5
> > Analog devices id 75].
> > 
> > I also have a problem when the drivers have been running for a long
> > time (around 5 hours). Without an xrun the snd_pcm_delay() function
> > starts returning impossible numbers. Checking drift against either
> > rdtsc or gettimeofday() alsa starts giving me a 0.1 second per
> > second drift.
> > 
> > I haven't got a machine I can set up for this style of kernel
> > debugging unfortunately, so I am trying to code around these
> > problems.
> > 
> > richard.
> > 
> > 
> Would you be able to submit a small self contained (like the 
> speaker-test code I submitted) source code that would reproduce the 
> problem quickly.
> I would expect that writing code to force xruns would be quite easy.
> I have a ICH5 with ALC650 chip on Motherboard here, so I might be able
> to help you out if I could reproduce your problem.
try to open/close (without seeking) in mplayer or xine - always scrolls
to next position (i think 3 positions at all).


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
