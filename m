From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: VIA8233/8235 testers wanted
Date: Fri, 10 Jan 2003 10:13:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301101013.58151.styx@gentoo.org>
References: <s5h7kde8dfm.wl@alsa2.suse.de> <200301100917.28794.styx@gentoo.org> <s5h3co18knt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3co18knt.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 10 January 2003 09:37, Takashi Iwai wrote:
> At Fri, 10 Jan 2003 09:17:28 +0100,
>
> Joachim Blaabjerg wrote:
> > On Thursday 09 January 2003 18:01, Takashi Iwai wrote:
> > > Hi,
> > >
> > > if someone has VIA8233, VIA8233A, VIA8233C or VIA8235 chipset, could
> > > you help the testing of the new driver?
> > > the new driver code is found at
> > >
> > > 	http://www.alsa-project.org/~iwai/via82xx.c
> > > [...]
> >
> > I'm getting an unresolved symbol: snd_pcm_substream_sgbuf, and a
> > recursive grep in the alsa-driver sources show only one match in, you
> > guessed it, snd-via82xx.c.
>
> please try the very latest cvs version.
> (the best is to get the source via cvs, not cvs-snapshot).
> there are many changes recently.

Ah yes, thanks.

It compiles and loads nicely, but there are some problems using it. I tried 
starting UT2003 while XMMS was playing, and there was indeed sound from both, 
but the UT2003 sound was quite choppy. When I exited UT2003, the last sound 
it played is still there, and plays over and over again (ut2003-bin hangs). I 
get the following warning from ALSA:

ALSA lib pcm_hw.c:398:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: 
Device or resource busy

I figured UT2003 and its sound system was probably rather weird, so I tried 
again with mpg231 and mplayer, which worked beautifully. Thanks! :)

Btw, this is a VT-8235 sound chip.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
