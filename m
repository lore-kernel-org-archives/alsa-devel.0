From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: Re: Yamaha 754 question...
Date: Mon, 13 May 2002 08:54:57 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205130843020.13149-100000@sorrow.ashke.com>
References: <s5hhelc8eg8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhelc8eg8.wl@alsa2.suse.de>
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


It's looking good so far :-)

I applied the patch and recompiled.  I haven't had much chance to test
since I had to leave for work (I'll test more tonight), but alsaplayer
worked without using the ch4dup bit from .asoundrc...  xmms worked fine,
with both the Alsa output plugin and the OSS plugin.  In all three cases,
I was getting four speaker output.

In addition, alsamixer shows a new option "4ch Duplication" so, in theory,
I can turn it off and have two alsaplayers going, one stream on the front
channel and a different one on the rear channel.  I haven't tested that
yet, though.

I'll have to take a close look at your patch now to see exactly what
you're doing.  I tried my handa t it some time last month, but ran into
some difficulties :-)

Adam

On Mon, 13 May 2002, Takashi Iwai wrote:

> At Fri, 10 May 2002 12:46:07 -0400 (EDT),
> Adam K Kirchhoff wrote:
> > 
> > 
> > No comment on this one? :-(
> 
> oh, you had bad luck ;)
> 
> now i did a very quick-n-dirty hack, the recipe was finished in 15
> minutes.  can you try the attached patch?
> 
> btw i've not tested at all (nor have i the hardware)..
> 
> 
> Takashi
> 




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
