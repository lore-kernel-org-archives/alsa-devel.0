From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 15:16:09 -0800
Message-ID: <5bdc1c8b050118151635963fd3@mail.gmail.com>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
	 <XFMail.20050118165036.pochini@shiny.it>
	 <s5hacr6wun5.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0501181822220.29107@denise.shiny.it>
	 <5bdc1c8b05011809454b58899c@mail.gmail.com>
	 <1106083806.24484.11.camel@krustophenia.net>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106083806.24484.11.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2005 16:30:06 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-01-18 at 09:45 -0800, Mark Knecht wrote:
> > But that sort of application level control is actually what's causing
> > me problems. Mozilla browses around and changes the frequency of the
> > card, independent of what the overall system architecture requires.
> >
> > Again, I think you're probably right about this issue for a completely
> > stand-alone system, but for a multi-PC system I think some sort of
> > plughw solution that resamples in software when necessary would work
> > better for me and Mozilla.
> 
> Mozilla is not the problem, most likely it's Flash which uses OSS to
> play sounds.  Unfortunately Mozilla can't play sounds at all, which
> means many of my favorite web sites like http://getyourasstomars.com
> don't work.
> 
> Lee
> 

OK, 'Mozilla' as a term is far too broad, and in my case it's only an
example of when this problem can happen. It also has happened when I
fire up some Gnome or KDE game, but what's strange is it doesn't
happen every time I do it. Don't ask me what that's about.

But, true, Mozilla doesn't play audio. I have Shockwave Flash and
Quicktime installed. QT comes from an iTunes installation under
Crossover Office I suppose...

thanks,
Mark


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
