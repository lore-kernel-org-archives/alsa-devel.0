From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: irq handler top half timestamps
Date: Thu, 09 Dec 2004 16:10:28 -0500
Message-ID: <1102626628.21688.11.camel@krustophenia.net>
References: <20041209180706.GA11397@elte.hu>
	 <200412091819.iB9IJiLX013123@localhost.localdomain>
	 <20041209183342.GB13132@elte.hu>  <20041209220741.7562b6a0@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041209220741.7562b6a0@mango.fruits.de>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-12-09 at 22:07 +0100, Florian Schmidt wrote:
> On Thu, 9 Dec 2004 19:33:42 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > cleanest would be to somehow make this part of ALSA, just like xrun info
> > is part of ALSA (the two are related as well). But there are other
> > details too i guess: a single audio device can have separate interrupts
> > (for playback and capture?) - in that case which one should ALSA return?
> 
> Well, possibly ALSA could keep the timestamps for each substream around?
> And the ioctl should get parametrized with the substream # so it returns
> the most current irq timestamp for the selected substream.
> 

Doesn't ALSA already do this?  IIRC when you call snd_pcm_period_elapsed
in the ALSA irq handler the PCM stream is timestamped.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
