From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: HDSPM: Wrong samplerate on PCI cards
Date: Sun, 22 Apr 2012 11:50:36 +0200
Message-ID: <4F93D46C.6040403@drcomp.erfurt.thur.de>
References: <20120418165913.1986107a@desk27.iosono.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 35D5E243B2
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Apr 2012 11:50:38 +0200 (CEST)
In-Reply-To: <20120418165913.1986107a@desk27.iosono.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andre Schramm <andre.schramm@iosono-sound.com>
Cc: alsa-devel@alsa-project.org, Andreas Graefe <andreas.graefe@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

On 04/18/2012 04:59 PM, Andre Schramm wrote:

> Hi,

Hi!

Sorry for kicking in so late, life's rather busy these days...

> we're having issues obtaining the correct system sample rate from PCI
> cards, while it works correctly for PCIe cards.



> hdspm.c:1988:   period = hdspm_read(hdspm, HDSPM_RD_PLL_FREQ);
>
>
> Output for PCIe card:
> hdspm_calc_dds_value: freq_const=110069313433624, period=2293110696,
> freq_const/period=48000
>
>
> Output for PCI card:
> hdspm_calc_dds_value: freq_const=110069313433624, period=41943044,
> freq_const/period=2624256

Weird. But if you say so, then yes, this would be the culprit.


> I tested with 3 different PCI cards (latest firmware) and the same
> card(s) works as expected on 32b-Kernel 2.6.24.7 with ALSA 1.0.16.

In 1.0.16, the driver simply returns hdspm->system_sample_rate instead
of calculating the rate via DDS.

What we can easily do is something (pseudo-code ahead) like:

    rate = calc_rate_via_dds;
    if (rate > 192k) {
       /* insane DDS value, use system_sample_rate instead */
       rate = hdspm->system_sample_rate;
    }
    return rate;

More like a workaround.

I'll send you a patch in a second.


> Within the driver, I don't see a different code path for PCI and
> PCIe, so this seems weird. I took a look at the Mac driver as well, it
> defines	RD_PLL_FREQ as 4*128, so this should be ok?

Yeah, the only explanation so far is that the PCI device is more different
than we tought.

> And the proc-output for the samplerate is wrong/misleading as it isn't
> read directly from the card as opposed to the RayDat-Code. Is there any
> reason for this?

Not that I'm aware of. Could probably use some refactoring. ;)



Cheers
