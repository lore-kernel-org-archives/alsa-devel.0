From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH] alsa: Disable
 timer-scheduling for PCMs with the BATCH flag
Date: Tue, 03 Dec 2013 10:02:44 +0100
Message-ID: <529D9E34.9050803@ladisch.de>
References: <1385831244-30750-1-git-send-email-lars@metafoo.de>
	<CAN8cciYz=ZFJNW_FNqKTceCV4S=pz3CwkbwKcTeZb4AM=7bWzw@mail.gmail.com>
	<529C5980.60408@metafoo.de>
	<CAN8ccib1Z-uA3vH0EDf_gtVm8kKaCkjhnZq1Kr=MitnRYpS1PA@mail.gmail.com>
	<s5h8uw25olr.wl%tiwai@suse.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <s5h8uw25olr.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Raymond Yau wrote:
>> usb-audio seem update when each URB send/receive (in 1ms intervals)

The default is to use larger intervals.

> The usb-audio driver behaved in a BATCH way in the very early version,
> but it was improved.

The delay reporting is more precise, but the DMA position still jumps
for each URB.

> So we can get rid of the flag from this driver now.

How well does timer-scheduling work with large URBs?

>> ymfpci driver also update hwptr in 5ms interval but no SNDRV_PCM_INFO_PATCH
>> and no constraint in period time must be interval of 5 ms

The period length (in frames) is not constant for most sample rates.

However, if the noresample flag is set (which should be the case with
PA), the period length should be constant, and such a period constraint
might make sense.  I'll have to test it ...


Regards,
Clemens
