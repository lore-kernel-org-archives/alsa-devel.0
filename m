From: Nixbits Admin <admin@nixbits.org>
Subject: Re: Kernel: snd-usb-audio: probe of 2-2:1.0 failed
	with error -5
Date: Tue, 29 Nov 2011 19:18:08 -0500
Message-ID: <4ED57640.5050804@nixbits.org>
References: <4ED4D58D.60109@nixbits.org>
	<CA+55aFxjrCZTEzznjEK_FjadortNS9GPtcDH=D8-HebKKhQ8Bg@mail.gmail.com>
	<4ED51463.6050005@gmail.com>
Reply-To: admin@nixbits.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0444E103983
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 01:18:17 +0100 (CET)
Received: by qyk2 with SMTP id 2so15582qyk.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 16:18:15 -0800 (PST)
In-Reply-To: <4ED51463.6050005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

I have included the output of lsusb -v and updated the topic.

https://forums.gentoo.org/viewtopic-p-6886404.html#6886404


 >>    Nov 29 07:21:21  kernel: skipping empty audio interface (v1)
 >>    Nov 29 07:21:21  kernel: snd-usb-audio: probe of 2-3:1.0 failed 
with error -5

H.

On 11/29/2011 12:20 PM, Daniel Mack wrote:
> On 11/29/2011 05:58 PM, Linus Torvalds wrote:
>> On Tue, Nov 29, 2011 at 4:52 AM, Nixbits Admin<admin@nixbits.org>  wrote:
>>>
>>> While knowing that your time is precious and without wanting to making you
>>> spend more than what you may be able to spare for my problem; i would like
>>> ask you if you could take a look at this issue.
>>>
>>> https://forums.gentoo.org/viewtopic-p-6885908.html#6885908
>>>
>>> snd-usb-audio: probe of 2-2:1.0 failed with error -5
>>
>> This is related to the line above it:
>>
>>    Nov 29 07:21:21  kernel: skipping empty audio interface (v1)
>>    Nov 29 07:21:21  kernel: snd-usb-audio: probe of 2-3:1.0 failed with error -5
>>
>> which in turn is because of a zero "bInCollection" value in the device
>> control header. I'm adding some sound people to the cc, in case
>> anybody has more clues about what's wrong with that particular device
>> - I don't personally have any real clue about usb audio.
>
> As the dump in the forum post doesn't decode any of the USB audio
> specific headers, we'd need to see the output of "lsusb -v" with that
> device connected.
>
> If the driver bails out at this point, there's something wrong with the
> descriptors, or the interface has no audio support at all (which would
> be odd as it could have been omitted entirely in the first place).
>
> We might have to add a quirk for the device, let's see.
>
>
> Daniel
>
