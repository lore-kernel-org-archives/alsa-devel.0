From: Martin Langer <martin-langer@gmx.de>
Subject: Re: full-duplex - is it possible with rme32?
Date: Mon, 6 May 2002 23:48:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020506214833.GA14102@localhost>
References: <20020502214400.GA2888@localhost> <s5hvga5mlvo.wl@alsa2.suse.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvga5mlvo.wl@alsa2.suse.de>
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

On Fri, May 03, 2002 at 02:55:23PM +0200, Takashi Iwai wrote:
> At Thu, 2 May 2002 23:44:00 +0200, Martin Langer wrote:
> > 
> > the RME Digi 32 in half-duplex is working so far, but I don't see a solution
> > for a full-duplex support, because this card is working with one buffer for
> > recording and playing.
> > 
> > A driver should write the playing data and read the recording data in one
> > cycle at the same address. There is no way to separate play/rec. It's just
> > working in a synchronized way: first get the rec-data and then overwrite it
> > with play-data, cycle for cycle,...
> 
> does the capture sample always overwrite the sample to be played?
> i.e. if the hardware sequence is
> 	capture -> playback
> on the same pointer, then i have no idea how to do full duplex at
> all.  but if the hardware does
> 	playback -> capture
> then there must be no problem.
> 

I'm not sure about my card. In the description I see both cases and I
don't know the right one (or the mistake) up to now.

I just can say "playback -> capture" looks more plausible for me at the
moment, so I hope having this case.

Definitely I can say this: Using the card ends in
- playing plays the play-data
- capturing captures the play-data in full-duplex-mode
- capturing captures the capture-data in half-duplex-mode

or with some different code (this code produces input/output errors):
- playing silence in full-duplex-mode
- capturing the capture-data in full-duplex-mode

Does another module exist, which works in that "playback -> capture" mode? 


martin

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
