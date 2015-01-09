From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: usb-audio: Add support for
	Akai	MPC Element USB MIDI controller
Date: Fri, 09 Jan 2015 09:48:42 +0100
Message-ID: <54AF95EA.90505@ladisch.de>
References: <54AE16D8.6080302@gmail.com> <54AEFCFF.3060406@ladisch.de>
 <54AF24D6.6010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5C1BA2614C1
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 09:48:44 +0100 (CET)
In-Reply-To: <54AF24D6.6010701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bonser <misterpib@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Paul Bonser wrote:
> On 01/08/2015 03:56 PM, Clemens Ladisch wrote:
>> Paul Bonser wrote:
>>> The Akai MPC Element incorrectly reports its bInterfaceClass as 255, but
>>> otherwise implements the USB MIDI spec correctly.
>>>
>>> This adds a quirks-table.h entry which allows the device to be
>>> recognized as a standard USB MIDI device.
>>>
>>> +++ b/sound/usb/quirks-table.h
>>> +{
>>> +	/* Akai MPC Element */
>>> +	USB_DEVICE(0x09e8, 0x0021),
>>> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
>>> +		.ifnum = QUIRK_ANY_INTERFACE,
>>> +		.type = QUIRK_COMPOSITE,
>>> +		.data = & (const struct snd_usb_audio_quirk[]) {
>>> +			{
>>> +				.ifnum = 0,
>>> +				.type = QUIRK_IGNORE_INTERFACE
>>> +			},
>>> +			{
>>> +				.ifnum = 1,
>>> +				.type = QUIRK_MIDI_STANDARD_INTERFACE
>>> +			},
>>> +			{
>>> +				.ifnum = -1
>>> +			}
>>> +		}
>>> +	}
>>> +},
>>
>> Why a composite quirk?  Does a single quirk entry not work?
>
> A single quirk entry results in an error message in dmesg:
> "snd-usb-audio: probe of 3-2:1.0 failed with error -5"

That message is normal for unhandled interfaces.

Does it actually prevent the device from working?


Regards,
Clemens
