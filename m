From: "Martijn Sipkema" <martijn@entmoot.nl>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Mon, 20 Dec 2004 11:57:56 +0100
Message-ID: <007001c4e682$c366aec0$161b14ac@boromir>
References: <200412102051.iBAKphFL012668@localhost.localdomain> <1102712509.29919.46.camel@krustophenia.net> <20041211015610.1798af34@mango.fruits.de> <1102735047.14237.8.camel@krustophenia.net>
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
To: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

[...]
> > When exactly is snd_pcm_period_elapsed called? Is it called from the
> > ALSA driver interrupt handler (excuse, if this question is stupid, i'm
> > not too well versed (mildly speaking) when it comes to driver hacking)?
> > Is it the first thing in the irq handling routine?
> 
> If the device supports interrupts at the period boundary like most sound
> cards it's the only thing in the ALSA interrupt handler:
> 
> static void snd_emu10k1_pcm_efx_interrupt(emu10k1_t *emu, unsigned int status)
> {
>         snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
> }
> 
> If the device uses a timer to generate interrupts at a fixed frequency
> then you have to manually compare the frames processed to the period
> size and call snd_pcm_period_elapsed if the period has indeed elapsed.

(sorry, a bit off-topic)
Does that mean that ALSA will always have a large (relative to the interrupt
frequency) scheduling jitter for cards that interrupt at a fixed frequency?
Or is it possible to have ALSA return samples immediately after they become
available?


--ms



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
