From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: emu10k1 MIDI record
Date: Sat, 12 Feb 2005 10:34:46 -0500
Message-ID: <1108222486.4267.186.camel@radium.gaugetheory.org>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
	 <1106678585.10845.8.camel@krustophenia.net>
	 <1108148630.4267.28.camel@radium.gaugetheory.org>
	 <1108151083.20365.9.camel@krustophenia.net>
	 <1108152402.4267.45.camel@radium.gaugetheory.org>
	 <1108152752.20365.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108152752.20365.26.camel@krustophenia.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee,

The keyboard is on - both cables in (i've swap-checked them - both good)

aplaymidi -p 64:32 carny.mid
good - tune plays on my keyboard.

arecordmidi --dump --port=64:32 foo.mid

_______Tick Event_________________ Ch _Data__
is all I get as I play notes on the keyboard.

foo.mid conatins only a header line of bytes:
MThd?MTrk?Q? ?X??+?/

Unfortunately, I do not yet have my sound card isolated on IRQ 9.
(I'm getting interrupts on it from other devices even without playing)

thanks,
brian

On Fri, 2005-02-11 at 15:12, Lee Revell wrote:
> On Fri, 2005-02-11 at 15:06 -0500, Brian L Scipioni wrote:
> > No.  Each MPU is full-duplex.  I don't use the MPU-401 #1 - it is
> > available through the 15 pin MIDI/Joystick-out on the PCI slot frame in
> > back, next to the card.
> > 
> > I use the MPU-401 #2 - the mini-DIN MIDI jack pair on the front "drive"
> > unit.  The MIDI-out works fine - I can play my keyboard with Rosegarden
> > or playmidi, e.g.  The MIDI-in doesn't seems to work (I've done a bit of
> > troubleshooting - swapped cables, etc.).
> 
> OK so you run:
> 
> arecordmidi --dump --port=64:32 foo.mid
> 
> and get no output, even when the keyboard is plugged in.
> 
> Does the interrupt count in /proc/interrupts increase when 
> you play at the keyboard?
> 
> Lee
> 
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
