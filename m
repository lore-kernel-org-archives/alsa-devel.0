From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Mon, 20 Dec 2004 12:10:25 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412201205010.20003-100000@studcom.urz.uni-halle.de>
References: <007001c4e682$c366aec0$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <007001c4e682$c366aec0$161b14ac@boromir>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Martijn Sipkema wrote:
> > If the device uses a timer to generate interrupts at a fixed frequency
> > then you have to manually compare the frames processed to the period
> > size and call snd_pcm_period_elapsed if the period has indeed elapsed.
>
> Does that mean that ALSA will always have a large (relative to the interrupt
> frequency) scheduling jitter for cards that interrupt at a fixed frequency?

Yes, if the hardware periods don't exaclty match ALSA periods.
(Using e.g. snd-ymfpci at 48 kHz with periods of 256 samples shouldn't
introduce any additional jitter.)

> Or is it possible to have ALSA return samples immediately after they become
> available?

The ALSA API assumes constant-sized periods.  (Jack's Tascam USB
driver bypasses the ALSA API.)


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
