From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Re: Yamaha 754 question...
Date: Mon, 20 May 2002 12:36:53 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BOS.4.10.10205201234100.1286-100000@sorrow.ashke.com>
References: <Pine.LNX.4.10.10205160909330.1876-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10205160909330.1876-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Thu, 16 May 2002, Adam K Kirchhoff wrote:

> >
> > hmm, init can be called multiple times.  i forgot it.
> >
> > the following is the revised patch.
> > now ac3_init and _done are called at module init/end stage, so there
> > will be no problems any more to switch 2ch/4ch accidentally.
> > could you give a try?
> 
> I haven't had a chance to thoroughly test it, but I gave it a quick shot
> this morning.  Using the same method that I was able to replicate the
> problem last time (playing a file with xmms and alsaplayer and then
> killing alsaplayer), I was unable to make it happen again.  
> 
> I'll try some more after I get home from work tonight.

Sorry for the delay in getting back to you...

I have tested this patch as rigorously as I think possible :-)  I have
been unable to get it to break and switch from 4ch to 2ch (or vice versa)
after a number of hours of playing games, mp3s, videos, etc.  Seems to
work great here.

Adam



_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
