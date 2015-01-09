From: Paul Bonser <misterpib@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2] ALSA: usb-audio: Add support for Akai
 MPC Element USB MIDI controller
Date: Thu, 08 Jan 2015 18:46:14 -0600
Message-ID: <54AF24D6.6010701@gmail.com>
References: <54AE16D8.6080302@gmail.com> <54AEFCFF.3060406@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54AEFCFF.3060406@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2015 03:56 PM, Clemens Ladisch wrote:
> Paul Bonser wrote:
>> The Akai MPC Element incorrectly reports its bInterfaceClass as 255, but
>> otherwise implements the USB MIDI spec correctly.
>>
>> This adds a quirks-table.h entry which allows the device to be
>> recognized as a standard USB MIDI device.
>>
>> Signed-off-by: Paul Bonser <misterpib@gmail.com>
>> ---
>> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
>> index 8590a32..e869b6c 100644
>> --- a/sound/usb/quirks-table.h
>> +++ b/sound/usb/quirks-table.h
>> @@ -2516,6 +2516,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>>  	}
>>  },
>>
>> +{
>> +	/* Akai MPC Element */
>> +	USB_DEVICE(0x09e8, 0x0021),
>> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
>> +		.ifnum = QUIRK_ANY_INTERFACE,
>> +		.type = QUIRK_COMPOSITE,
>> +		.data = & (const struct snd_usb_audio_quirk[]) {
>> +			{
>> +				.ifnum = 0,
>> +				.type = QUIRK_IGNORE_INTERFACE
>> +			},
>> +			{
>> +				.ifnum = 1,
>> +				.type = QUIRK_MIDI_STANDARD_INTERFACE
>> +			},
>> +			{
>> +				.ifnum = -1
>> +			}
>> +		}
>> +	}
>> +},
> 
> Why a composite quirk?  Does a single quirk entry not work?

A single quirk entry results in an error message in dmesg:
"snd-usb-audio: probe of 3-2:1.0 failed with error -5"

Adding the QUIRK_IGNORE_INTERFACE stops that.

> 
> 
> Regards,
> Clemens
> 
