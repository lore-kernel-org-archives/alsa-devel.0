From: "Martijn Sipkema" <martijn@entmoot.nl>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Mon, 20 Dec 2004 12:50:08 +0100
Message-ID: <01a001c4e68a$0e1096a0$161b14ac@boromir>
References: <Pine.HPX.4.33n.0412201205010.20003-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > If the device uses a timer to generate interrupts at a fixed frequency
> > > then you have to manually compare the frames processed to the period
> > > size and call snd_pcm_period_elapsed if the period has indeed elapsed.
> >
> > Does that mean that ALSA will always have a large (relative to the interrupt
> > frequency) scheduling jitter for cards that interrupt at a fixed frequency?
> 
> Yes, if the hardware periods don't exaclty match ALSA periods.
> (Using e.g. snd-ymfpci at 48 kHz with periods of 256 samples shouldn't
> introduce any additional jitter.)
> 
> > Or is it possible to have ALSA return samples immediately after they become
> > available?
> 
> The ALSA API assumes constant-sized periods.  (Jack's Tascam USB
> driver bypasses the ALSA API.)

Ah, I'll have a look at that; I was able to buy a Swissonic USB studio D for
a very good price and now I want low latency with this "bad" hardware. :)
I would be nice to have ALSA support non-constant periods (transfer is a
better term in that case I think).


--ms



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
