From: Martin Langer <martin-langer@gmx.de>
Subject: [OT] Re: Virus/Worms/Spam problem from portuguese dial-in mail server ?
Date: Sun, 4 Apr 2004 21:12:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040404191233.GA1113@tuba.home>
References: <20040404073736.GA663@tuba.home> <32876.192.168.1.5.1081097195.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <32876.192.168.1.5.1081097195.squirrel@www.rncbc.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 04, 2004 at 05:46:35PM +0100, Rui Nuno Capela wrote:
> >
> > damned. What's that? A dial-in account for spammers from netcabo.pt???
> 
> No dial-in but cable. Netcabo.pt is my ISP, and rncbc.org is just my own
> dynamic DNS domain name, although it's IP address hasn't change for almost
> more than an year.
> 

Is it possible to run a local smtp server without using the smarthost of
your provider by dynamic IP. Then it's easy to spam around. So I
understand the reason why those IPs are blacklisted. Dynamic IP's aren't
static. 

> > Still in hope that you're not the reason for my virus/worm traffic
> > explosion. Please, don't take it personally. It's only the spam/virus
> > traffic I hate.
> 
> I hate it too, and thank you for pointing me out. Maybe I'm a bit relaxed
> about my sendmail administration, but I am confident that it's not
> configured as an open relay. I will check it out a little more deeper,
> rest assured.

If it's a dynamic IP range and someone spams there, they will blacklist the
whole range. Blacklisting only one IP wouldn't solve the problem.

> Help me out in clearing this up. Please.

I remember a similar discussion in a longer thread here:
http://www.music.columbia.edu/pipermail/linux-audio-dev/2003-September/004935.html

Use a smarthost for your mails and the sun will shine again.


martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
