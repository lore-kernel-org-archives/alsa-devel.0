From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Fri, 10 Dec 2004 22:17:27 -0500
Message-ID: <1102735047.14237.8.camel@krustophenia.net>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	 <1102712509.29919.46.camel@krustophenia.net>
	 <20041211015610.1798af34@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041211015610.1798af34@mango.fruits.de>
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
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-12-11 at 01:56 +0100, Florian Schmidt wrote:
> On Fri, 10 Dec 2004 16:01:48 -0500 Lee Revell <rlrevell@joe-job.com> wrote:
> > I don't really consider this new level very significant in practice
> > because it's fast and exactly the same for all devices.  IOW the
> > snd_pcm_period_elapsed timestamp should be good.  I don't think we need
> > to worry about the threaded ALSA IRQ case.
> 
> When exactly is snd_pcm_period_elapsed called? Is it called from the
> ALSA driver interrupt handler (excuse, if this question is stupid, i'm
> not too well versed (mildly speaking) when it comes to driver hacking)?
> Is it the first thing in the irq handling routine?

If the device supports interrupts at the period boundary like most sound
cards it's the only thing in the ALSA interrupt handler:

static void snd_emu10k1_pcm_efx_interrupt(emu10k1_t *emu, unsigned int status)
{
        snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
}

If the device uses a timer to generate interrupts at a fixed frequency
then you have to manually compare the frames processed to the period
size and call snd_pcm_period_elapsed if the period has indeed elapsed.

Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
