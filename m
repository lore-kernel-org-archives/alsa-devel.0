From: Sander Jansen <s.jansen@gmail.com>
Subject: Re: Resend: Incorrect sbits for snd-usb-audio
Date: Sun, 8 Dec 2013 12:47:31 -0600
Message-ID: <CACj81kGcpr4YpdwTkcfvRzYTf9ANRgZ3r7w4QgQ9ZREse0VxPg@mail.gmail.com>
References: <CACj81kFSv1gUJMkvJ6BUHupTKuwYqrPNO0BbnVJU1QVK853GUQ@mail.gmail.com>
 <s5hk3ffr952.wl%tiwai@suse.de>
 <CACj81kE86jmoqyMmYFJqx8NKL+R3WPonwrOoScfZJXLR72JuFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CCD2261B36
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 19:47:32 +0100 (CET)
Received: by mail-vc0-f172.google.com with SMTP id ij19so864775vcb.3
 for <alsa-devel@alsa-project.org>; Sun, 08 Dec 2013 10:47:31 -0800 (PST)
In-Reply-To: <CACj81kE86jmoqyMmYFJqx8NKL+R3WPonwrOoScfZJXLR72JuFA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 8, 2013 at 12:27 PM, Sander Jansen <s.jansen@gmail.com> wrote:

>
>
> On Sun, Dec 8, 2013 at 3:20 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Fri, 6 Dec 2013 14:57:46 -0600,
>> Sander Jansen wrote:
>> >
>> > Hi,
>> >
>> > I had send this out earlier back in September, but never got a response.
>> >
>> > I have a Focusrite Scarlett 2i4 USB Audio Interface. The audio format
>> > exposed by ALSA for  this device is S32_LE. From the hardware specs and
>> > lsusb. it supposed to only have a 24 bit resolution (with the LSB bits
>> set
>> > to 0):
>> >
>> > AudioStreaming Interface Descriptor:
>> >         bLength                 6
>> >         bDescriptorType        36
>> >         bDescriptorSubtype      2 (FORMAT_TYPE)
>> >         bFormatType             1 (FORMAT_TYPE_I)
>> >         bSubslotSize            4
>> >         bBitResolution         24
>> >
>> > When I query the sbits for this device, I expect it to return 24, but
>> > instead it returns 32. Looking through the usb audio driver code, it
>> > doesn't look like this information is actually exposed to userspace. The
>> > 'parse_audio_format_i_type'  in usb/format.c merely returns the
>> supported
>> > formats, but doesn't include any msbits info. (and it doesn't look like
>> it
>> > can be easily changed to return the msbits info as well).
>> >
>> > Was this intentionally left out, or is this a missing feature in the
>> driver?
>>
>> It's just because of laziness because almost no applications check the
>> msbit but only the format type.  Feel free to send an enhancement
>> patch.
>>
>>
>>
> Thanks for the clarification. I may give that a shot.
>
> Sander
>
>
Forgive my ignorance, but to which git tree should this patch be developed
on?

git://git.alsa-project.org/alsa-kernel.git
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
?

Thanks,

Sander
