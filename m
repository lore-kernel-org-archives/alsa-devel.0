From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Moving from OSS to ALSA
Date: Mon, 12 Jan 2004 09:42:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401120938110.1941@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0401120053050.22195-100000@vaino.wakkanet.fi>
 <200401121115.05195.lpotter@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401121115.05195.lpotter@trolltech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lorn Potter <lpotter@trolltech.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Jan 2004, Lorn Potter wrote:

> > Believe me, I agree with you 100% with regards to importance of
> > simplicity. ALSA still has some complex edges, but is has come a long way.
> > More documentation, tutorials and example code are still needed, but it
> > takes time (and volunteers) to create them. I'm sure help is appreciated.
> 
> The problem here is, the people writing docs/tutorials need in depth knowledge 
> of how this all works. And unfortunately, the best people to do this are the 
> developers themselves. 

Basically, developers are not good documentation writers, because they 
might ommit important things for people which need some introduction. I 
still hope, that the community will ask us for deep details and send us 
pieces of documentation back.

> > But that's just one example. ALSA needs to support much more complex mixer
> > configurations than OSS, and this of course comes with a price.
> >
> > It is very difficult to try to hide all this complexity from the developer
> > without in the end limiting what the developer can do. So it's a question
> > of finding out a good balance between what can be done and how easy it is.
> > I guess currently ALSA is still too much on the complex side, but slowly
> > the correct balance will be found... So your input is very much
> > appreciated, but at the same time, please don't lose hope just yet. :)
> 
> Oh, I havent lost hope at all. I am very excited about ALSA nearing version 1.
> 
> I don't want to limit what alsa can do, only have access to a simple-ized part 
> of the API, that's fast and easy for developers to write.  Which is what I 
> view the OSS compat. to be.
> 
> I work with embedded devices, and so I am always thinking of ways to optimize 
> the code and make apps smaller, which also means writing more app with less 
> code.

Yes, we're aware that our APIs are rather too much complicated for simple 
applications. We are designing the very simple (current name ordinary) 
APIs to let more developers join us. But as Kai noticed, these APIs will 
be a bit limited, so they won't be intended for more complex applications.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
