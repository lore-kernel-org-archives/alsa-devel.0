From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Testers needed: memio-mmap patch (rme32,rme96,nm256)
Date: Tue, 13 Jul 2004 21:54:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040713195442.GA18453@tuba.home>
References: <s5hllikor62.wl@alsa2.suse.de> <20040620101135.GA755@tuba.home> <s5hd63fallg.wl@alsa2.suse.de> <20040701201326.GA567@tuba.home> <s5hzn6i8tf5.wl@alsa2.suse.de> <20040705184731.GA564@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040705184731.GA564@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, pilo.c@wanadoo.fr
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 05, 2004 at 08:47:31PM +0200, Martin Langer wrote:
> On Fri, Jul 02, 2004 at 02:50:22PM +0200, Takashi Iwai wrote:
> > At Thu, 1 Jul 2004 22:13:26 +0200,
> > Martin Langer wrote:
> >  
> > > FYI: The situation is that I get only silence in fullduplex_mode after a
> > > short time. But nevertheless in the beginning it is correct.
> > 
> > How about the attached patch?
> 
> Fine, there's no longer silence via the indirect way. But I'm still unhappy
> because the resulting data fragments on playback and capturing aren't clean.
> I mean there are often capturing fragments in the playback data; and OTOH 
> you can get playback fragments during capturing. And the length of this
> fragments and the winning data type (playback or capture) seems to be chaotic
> for my ears.

If I understand the fullduplex mode correct: then playback is sometimes the
winning process and another time it is capturing. I guess the code works
fine if playback wins the race. But if capturing is the winner, the playback
buffer isn't prefilled and the capture data will also be used in playback.

I don't see a rule that says: prefill the playback buffer before you run
capturing. But perhaps I'm totally blind at the moment.


martin



-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
