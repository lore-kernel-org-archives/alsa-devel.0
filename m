From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: The ALSA Situation
Date: 10 Nov 2004 15:53:08 -0800
Message-ID: <1100130788.27843.76.camel@cmn37.stanford.edu>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
	 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-10 at 14:34, Linus Torvalds wrote:
> On Wed, 10 Nov 2004, Paul Davis wrote:
> > 
> > i think you missed my point about program exit not being synonymous
> > with close(2). if prog1 closes the device but then does something else
> > for a while, prog2 doesn't run till prog1 exits (in the above shell
> > script). 
> 
> Yes. 
> 
> > with the block-on-busy-open behaviour, prog2 runs but blocks on open
> > and then continues as soon as prog1 does the close().
> 
> No, prog wouldn't even have started until prog1 exited, so the behaviour 
> would be exactly the same.
> 
> And if the programs put themselves in the background, well, then the order 
> of them is totally undefined, so then prog2 might end up opening the sound 
> device _before_ prog1 even got to it. So I really don't see your point, 
> except as some very unlikely (and apparently totally broken) situation.
> 
> > btw, xmms is a sort-of relevant example of this. xmms opens and closes
> > the audio device several times during a typical use pattern
> 
> So? It will still end up doing exactly the same waiting. It just does it 
> at the close instead of at the open.
> 
> Maybe the timing is different, but does anybody really care?
> 
> If anything, I suspect that the "flush on close" should _not_ wait for the 
> sound to have stopped, because you may have applications that open and 
> close the thing, and you want the sound to be contiguous and you do _not_ 
> want to hear popping. 
> 
> So to avoid the popping issue, I'd suggest that the "flush on close"  
> doesn't actually wait for the sound to end, but it might wait until the
> final sound fragment has been sent to the device. So hopefully the next 
> app has a few milliseconds of time to re-open the stream and start filling 
> the buffers again, so that you don't get any popping.

If the end of the sound being played has an envelope that gradually[*]
decreases to zero and the last sample of the last buffer is zero, the
soundcard should not pop when the stream is closed. Unless there are
hardware issues impossible to solve through software I'd call that a
bug. 

If the samples being played end abruptly (ie: the last sample of the
last buffer to be played is non-zero) then there will be a pop
independently of whether we chain apps or not. It is highly unlikely
that the next app will start playing a sound that happens to have the
same starting DC level as the previous one ended with. Jump in DC level
== pop. 

-- Fernando

[*] I don't have a strict definition of what "gradually" would be, my
guesstimate would be minimum of between 5 and 10 milliseconds. 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
