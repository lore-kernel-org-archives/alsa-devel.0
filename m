From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [linux-audio-dev] muse and /dev/rtc
Date: Mon, 22 Nov 2004 13:21:07 -0500
Message-ID: <1101147668.2873.29.camel@krustophenia.net>
References: <200411202259.57503.lad@koloro.de>
	 <20041122150120.GB20860@bth05w.ABSp.alcatel.be>
	 <Pine.LNX.4.58.0411221633160.23424@wotan.suse.de>
	 <200411221813.23092.rj@spamatica.se>
	 <20041122175312.GA20957@bth05w.ABSp.alcatel.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041122175312.GA20957@bth05w.ABSp.alcatel.be>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

(added alsa-devel to cc)

On Mon, 2004-11-22 at 18:53 +0100, Alfons Adriaensen wrote:
> Which leads to the following question I've been asking myself for some time:
> 
> the ALSA sequencer API seems to allow *timestamped* events - you put such
> an event in a queue and it will appear at the other end at the right moment.
> If this is true, and if ALSA has an high precision timer available to
> implement it, why should apps like MusE bother to do the fine timing
> themselves ? 

Yes, my thoughts exactly.  You don't even have to use the ALSA sequencer
API, you can use the ALSA timer API directly.  You get multiple timer
sources (system, RTC, sound card).  It should also be more portable.
For example if your sound card's timer is supported by your ALSA driver
like emu10k1 and ymfpci then I think you can use this timer to give
better sync with the hardware.

ALSA devs, is this correct?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
