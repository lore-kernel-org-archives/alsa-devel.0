From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Re: Yamaha 754 question...
Date: Thu, 16 May 2002 09:12:26 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205160909330.1876-100000@sorrow.ashke.com>
References: <s5h7km45r0g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7km45r0g.wl@alsa2.suse.de>
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


On Thu, 16 May 2002, Takashi Iwai wrote:

> At Tue, 14 May 2002 11:13:56 -0400 (EDT),
> Adam K Kirchhoff wrote:
> > 
> > 
> > OK...  So I got around to testing how snd_ymfpci_ac3_init and
> > snd_ymfpci_ac3_done are being handled.  You'll have to tell me if the
> > results sound good, though.
> > 
> > Playing back one small wav file (3930 bytes) with "play" (so it's not
> > using any sound daemons) results in entering _init one and entering _done
> > once.
> > 
> > Playing back a slightly larger wav file (12250 bytes) results in entering
> > _init 3 times, and _done once.
> > 
> > An even larger wav file: _init 4 times, _done once...
> > 
> > The largest wav file I can find will still only enter _init 4 times...
> > _done only ever seems to get called once (as you'd expect).
> 
> hmm, init can be called multiple times.  i forgot it.
> 
> the following is the revised patch.
> now ac3_init and _done are called at module init/end stage, so there
> will be no problems any more to switch 2ch/4ch accidentally.
> could you give a try?

I haven't had a chance to thoroughly test it, but I gave it a quick shot
this morning.  Using the same method that I was able to replicate the
problem last time (playing a file with xmms and alsaplayer and then
killing alsaplayer), I was unable to make it happen again.  

I'll try some more after I get home from work tonight.

Adam



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
