From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH] alsa: Disable
 timer-scheduling for PCMs with the BATCH flag
Date: Tue, 03 Dec 2013 13:42:04 +0100
Message-ID: <529DD19C.8080501@ladisch.de>
References: <1385831244-30750-1-git-send-email-lars@metafoo.de>
	<CAN8cciYz=ZFJNW_FNqKTceCV4S=pz3CwkbwKcTeZb4AM=7bWzw@mail.gmail.com>
	<529C5980.60408@metafoo.de>
	<CAN8ccib1Z-uA3vH0EDf_gtVm8kKaCkjhnZq1Kr=MitnRYpS1PA@mail.gmail.com>
	<s5h8uw25olr.wl%tiwai@suse.de> <529D9E34.9050803@ladisch.de>
	<s5hwqjm46iv.wl%tiwai@suse.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <s5hwqjm46iv.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> Raymond Yau wrote:
>>>> usb-audio seem update when each URB send/receive (in 1ms intervals)
>>
>> The default is to use larger intervals.
>>
>>> The usb-audio driver behaved in a BATCH way in the very early version,
>>> but it was improved.
>>
>> The delay reporting is more precise, but the DMA position still jumps
>> for each URB.
>>
>>> So we can get rid of the flag from this driver now.
>>
>> How well does timer-scheduling work with large URBs?
>
> I thought PCM runtime delay should give the accurate sample position,
> irrespective to URB size?

The position of the sample that is currently being played is accurate
(rounded to a USB frame).  The DMA position, however, changes only in
URB-sized increments.  (And that is accurate too, because it describes
exactly how the data is copied out of the buffer.)

> It should suffice for PA to control via timer scheduling.

Large jumps in the DMA position mean that there is a large part of the
buffer which cannot be safely changed by PA.  If this is why PA wants to
disable tsched, then the BATCH flag should stay.


Regards,
Clemens
