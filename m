From: Martin Langer <martin-langer@gmx.de>
Subject: Re: problems with rme digi96/8
Date: Mon, 9 Jun 2003 19:23:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030609172302.GA498@tuba.home>
References: <1054808252.7022.8.camel@duff> <20030605190335.GB493@tuba.home> <1054893994.2069.47.camel@duff>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1054893994.2069.47.camel@duff>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gorm David Lai <lai@daimi.au.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 06, 2003 at 12:06:33PM +0200, Gorm David Lai wrote:
> On Thu, 2003-06-05 at 21:03, Martin Langer wrote:
> > On Thu, Jun 05, 2003 at 12:17:32PM +0200, Gorm David Lai wrote:
> > > 
> > > We have recently bought a RME Digi96/8 card. This connects via adat to a
> > > mixing console.
> > 
> > ADAT isn't well tested, so everything is possible. But a look to wiki page
> > on http://opensrc.org/alsa/index.php?page=rme96 looks not so bad.
> > 
> > Are you using plughw:0,1 or hw:0,1? What's your alsa version? 
> > 
> Well, I test and set only legal settings on the hardware. So every
> setting I set returns success.
> 
> I normally use hw:0,1, but just tried with plughw:0,1. Sadly with no
> luck.
> My legal settings do not follow those on the page. The period size seems
> to match, but my only legal buffer size is 4096. This seems to be
> contrary to the info on the page. I also use a sample  size of 16.
 
I read on this page:

For using ADAT, in case of 16 bit:
- 512 frames and 8 periods ( 512*8=4096 ) 
- 128 frames and 32 periods ( 128*32=4096 )

Why does it not match your 16bit case? Have you choosen spdif values instead?

But the best would be a view into the hardware description, which was under
ftp://ftp.alsa-project.org/documentation/rme/ IIRC. 


martin




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
