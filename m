From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 08:58:28 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org> <s5his8cfiot.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his8cfiot.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 11 Nov 2004, Takashi Iwai wrote:
> 
> Well, the contiguous use of a stream isn't easy as it sounds.
> Since each app wants different buffer size, period (fragment) size,
> sample format, sample rate etc, the configuration must be reset
> totally at each time.  This eventually requires to stop of the DMA.

... and the sane thing to do would be to let apps use default parameters, 
and _encourage_ that, so that they only have problems if they want to do 
something strange.

> It's possible to check the condition and contine if it's identical
> with the previous one, though.  But I feel it's overdesigned as the
> driver.  A practical way to avoid popping would be the damping as
> Fernando suggested (if h/w doesn't support soft-muting).

The popping is just a small thing. The bigger thing is that people want to 
have a sound device open and send occasional beeps to it and things. 
Without having to wait for everybody else to close their stream.

If a window manager can't send a beep because the user is listening to 
music, that's a bad thing. If the interfaces are designed so that the 
trivial case is hard, that's a bad thing. And it sounds like they are.

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
