From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda: set the 2nd headphone's name to
 be Headphone2
Date: Wed, 6 Mar 2019 08:23:06 +0800
Message-ID: <1d8e9e63-3f2d-5351-1f29-d10f3db26313@canonical.com>
References: <20190305140910.25615-1-hui.wang@canonical.com>
 <18c107ea-6535-36c2-c8d0-a03397848c09@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <18c107ea-6535-36c2-c8d0-a03397848c09@perex.cz>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019/3/6 上午4:00, Jaroslav Kysela wrote:
> Dne 05. 03. 19 v 15:09 Hui Wang napsal(a):
>> Recently I saw two Headphones on some HP machines, the 1st Headphone
>> comes from the Front Headphone Jack, the 2nd one comes from the Front
>> Headset Jack, and the current HDA driver will set the same name to
>> them and with different index, just like below:
>> 'Headphone Playback Volume'
>> 'Headphone Playback Switch'
>> 'Headphone Playback Volume' index 1
>> 'Headphone Playback Switch' index 1
>> 'Front Headphone Jack'
>> 'Front Headphone Jack' index 1
>>
>> This can't be handled by pulseaudio, and pulseaduio already has a
>> path analog-output-headphones-2.conf to handle the 2nd headphone, now
>> we set the 2nd headphone's name to "Headphone2", leave the other
>> headphones unchanged.
>>
>> The change of hda_auto_parser.c will change the name of Jack.
>>
>> The change of hda_generic.c will change the name of Volume and Switch.
> NAK. I'm afraid, but you're trying to revert the change from 2009:
>
> commit 668b9652be33510a2a42b290dd335d34d38e2068
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Fri Mar 6 10:13:24 2009 +0100
>
>   ALSA: hda - Create multiple HP / speaker controls with index
>
>   Create multiple "Headphone" and "Speaker" controls with non-zero index
>   numbers instead of "Headphone2", etc.
>
>   Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> I think that PA should be fixed instead try to fix the drivers. The
> indexes are exactly designed to distinguish the multiple similar I/O.
>
> I cannot find any other driver which uses the Headphone2 control name.
>
> 					Jaroslav
>
OK, got it.  I tried to add the index to the pulseaudio in Jan, but not
finish yet.  If you have time, please take a look at my patches and make
a comment on them.

https://lists.freedesktop.org/archives/pulseaudio-discuss/2019-January/030761.html

Thanks,

Hui.
