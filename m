From: Martin Langer <martin-langer@gmx.de>
Subject: Re: full-duplex - is it possible with rme32?
Date: Tue, 18 Jun 2002 01:05:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020617230530.GA7821@localhost>
References: <20020502214400.GA2888@localhost> <s5hvga5mlvo.wl@alsa2.suse.de> <20020506214833.GA14102@localhost>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020506214833.GA14102@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, May 06, 2002 at 11:48:33PM +0200, Martin Langer wrote:
> On Fri, May 03, 2002 at 02:55:23PM +0200, Takashi Iwai wrote:
> > At Thu, 2 May 2002 23:44:00 +0200, Martin Langer wrote:
> > > 
> > > the RME Digi 32 in half-duplex is working so far, but I don't see a solution
> > > for a full-duplex support, because this card is working with one buffer for
> > > recording and playing.
> > > 
> > > A driver should write the playing data and read the recording data in one
> > > cycle at the same address. There is no way to separate play/rec. It's just
> > > working in a synchronized way: first get the rec-data and then overwrite it
> > > with play-data, cycle for cycle,...
> > 
> > does the capture sample always overwrite the sample to be played?
> > i.e. if the hardware sequence is
> > 	capture -> playback
> > on the same pointer, then i have no idea how to do full duplex at
> > all.  but if the hardware does
> > 	playback -> capture
> > then there must be no problem.
> > 
> 
> I'm not sure about my card. In the description I see both cases and I
> don't know the right one (or the mistake) up to now.
> 

I asked RME about the real behaviour and the answer was something like this:
The sample for playing is the first one in the buffer. Capturing at the same
time will overwrite this sample...

So we have the hardware sequence: capture -> playback
and this is like "good-bye full duplex!" for the rme32.


martin


----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                      >>>     http://thinkgeek.com/sf    <<<
