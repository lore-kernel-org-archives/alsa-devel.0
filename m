From: Gorm David Lai <lai@daimi.au.dk>
Subject: Re: problems with rme digi96/8
Date: 11 Jun 2003 14:22:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055334156.1391.38.camel@duff>
References: <1054808252.7022.8.camel@duff> <20030605190335.GB493@tuba.home>
	<1054893994.2069.47.camel@duff>  <20030609172302.GA498@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030609172302.GA498@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-06-09 at 19:23, Martin Langer wrote:
> On Fri, Jun 06, 2003 at 12:06:33PM +0200, Gorm David Lai wrote:
> > On Thu, 2003-06-05 at 21:03, Martin Langer wrote:
> > > On Thu, Jun 05, 2003 at 12:17:32PM +0200, Gorm David Lai wrote:
> > > > 
> > > > We have recently bought a RME Digi96/8 card. This connects via adat to a
> > > > mixing console.
> > > 
> > > ADAT isn't well tested, so everything is possible. But a look to wiki page
> > > on http://opensrc.org/alsa/index.php?page=rme96 looks not so bad.
> > > 
> > > Are you using plughw:0,1 or hw:0,1? What's your alsa version? 
> > > 
> > Well, I test and set only legal settings on the hardware. So every
> > setting I set returns success.
> > 
> > I normally use hw:0,1, but just tried with plughw:0,1. Sadly with no
> > luck.
> > My legal settings do not follow those on the page. The period size seems
> > to match, but my only legal buffer size is 4096. This seems to be
> > contrary to the info on the page. I also use a sample  size of 16.
>  
> I read on this page:
> 
> For using ADAT, in case of 16 bit:
> - 512 frames and 8 periods ( 512*8=4096 ) 
> - 128 frames and 32 periods ( 128*32=4096 )
> 
> Why does it not match your 16bit case? Have you choosen spdif values instead?
> 
> But the best would be a view into the hardware description, which was under
> ftp://ftp.alsa-project.org/documentation/rme/ IIRC. 
> 
> 
> martin
> 
> 
I misunderstood the buffer size, I thought it was in kb not i frames.
Not I understand. Also from the documentation I read that the card has a
hardware buffer size of 64KB, which matches 4096 frames in 8 channels.
I have tried the hw:0,0 for spdif btw, but that doesn't work either.

Now I have also tried setting some of the sw_params. I seems the value
set by snd_pcm_sw_params_set_start_threshold affects things greatly.
What happens is that i can fill the buffer with samples, though at some
point I suddenly get an underrun, as if the entire buffer is emptied at
once. The value set by snd_pcm_sw_params_set_start_threshold
approximately determines how often this happens.

As said earlier these problems only occur with the rme card. 

I looked in the cards documentation, but I am not sure what I can use
most of this for, unless I want to bypass ALSA entirely.

/Gorm





-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
