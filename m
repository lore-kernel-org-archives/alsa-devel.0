From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Re: Yamaha 754 question...
Date: Mon, 13 May 2002 17:33:33 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205131720120.3704-100000@sorrow.ashke.com>
References: <s5hd6w086j2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6w086j2.wl@alsa2.suse.de>
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


On Mon, 13 May 2002, Takashi Iwai wrote:

> At Mon, 13 May 2002 08:54:57 -0400 (EDT),
> Adam K Kirchhoff wrote:
> > 
> > 
> > It's looking good so far :-)
> > 
> > I applied the patch and recompiled.  I haven't had much chance to test
> > since I had to leave for work (I'll test more tonight), but alsaplayer
> > worked without using the ch4dup bit from .asoundrc...  xmms worked fine,
> > with both the Alsa output plugin and the OSS plugin.  In all three cases,
> > I was getting four speaker output.
>  
> good.
> the only concern is whether snd_ymfpci_ac3_init/_done is properly
> handled.  could you check (by adding printk in these routines, for
> example) whether these functions are called only once per open/close
> devices?

I'll try that out tonight.

> also, could you check multiple playbacks?

I'm getting some interesting results with this :-)

I'm booted into KDE and I have artsd running...  As KDE starts up artsd
plays it's audio file fine, with all four speakers.

If I set xmms to use the OSS output plugin, the mp3 I'm playing starts up
fine with all four speakers...  Somewhere along the way, the rear channel
drops out completely.  It seems to be hit or miss.  Sometimes I can
actually get through the file without any problems.  Sometimes it drops
out nearly immediately.

A sure fire way to duplicate the problem, though, is to start up
alsaplayer with another song..  Both songs will now play on all four
speakers.  So now I have artsd running, xmms running with the OSS plugin,
and alsaplayer is running :-)  If I quit alsaplayer, the rear speakers
will cut out for the song playing on xmms.  If I then hit "x" to restart
the song, it begins again with all four speakers :-)

> > In addition, alsamixer shows a new option "4ch Duplication" so, in theory,
> > I can turn it off and have two alsaplayers going, one stream on the front
> > channel and a different one on the rear channel.  I haven't tested that
> > yet, though.
>  
> this is even possible without my patch.

Yeah, I did notice that too.  The only reason I mentioned it this time
around is because I thought it was nice that it was still possible to do
this by muting that switch :-)

Adam


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
