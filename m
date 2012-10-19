From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 20:02:28 +0200
Message-ID: <508195B4.2090809@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop> <5081539E.40705@gmail.com>
 <1350654327.8310.4.camel@didier-laptop> <50815B51.3090402@gmail.com>
 <1350659344.5494.11.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D754265CAD
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 20:02:33 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so282523bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:02:32 -0700 (PDT)
In-Reply-To: <1350659344.5494.11.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19.10.2012 17:09, Didier 'Ptitjes' Villevalois wrote:
> On ven., 2012-10-19 at 15:53 +0200, Daniel Mack wrote:

>>>>> It seems to contain a Texas Instrument TUSB3200AC chipset (same chipset
>>>>> as the Maya44 USB and Hercules DJ console). I guess the problem is a
>>>>> firmware problem but I don't know what to do about it.
>>>>>
>>>>> I've got a MacOS X driver that works correctly, if that of any help. (I
>>>>> suppose the Windows driver works too but I don't have any Windows at
>>>>> hand.)
>>>>
>>>> Did you install any vendor driver on OS X or does it just work with the
>>>> one that ships with the OS?
>>>
>>> Yep, I had to install the Vendor-provided driver.
>>
>> What was the effect without that special driver? Could you see the
>> device listed in the AudioMIDISetup? Could you stream audio? IOW, is the
>> effect you see there comparable to how your Linux box behaves? You could
>> try and remove that driver again and see what happens.
> 
> So here is what I did:
> 
> 1) Removed the MacOs X driver and rebooted
> 2) Launched AudioMIDISetup (I did not know of this tool before :p)
> 3) Launched Mixxx
> 
> Now the box is outputing some crazy sound when Mixxx is not playing.
> When I start playing a track some more noise adds to the existing noise.
> Is this simply a PCM format error (sample rate/bit depth) ??
> 
> The fun thing (if I can say that) is that after rebooting to Linux 3.5.7
> there is now the same sound when I run Mixxx/Linux!! And I can observe
> the same added noise when I launch a track.

Ok, so this proves that their driver downloads a volatile firmware to
the device, which is rather bad news.

What you observe also tells us that even the new firmware is not
compliant to the USB audio standard which is really strange. I don't
know what they wouldn't go the class-compliant way with their firmware
as that's much easier than writing an own driver :-/

>>> Also the mpkg install file (inside the provided install dmg file) was
>>> called something like "firmware0_and_driver.mpkg". This is why I
>>> suspected a firmware problem. However I tried to look at the package
>>> content and did not find any .bin file or whatever could be a standalone
>>> firmware file. Maybe it is embedded in the driver install executable.
>>
>> Maybe, but they could also write the firmware permanently to the device
>> once with that tool. That would be perfect for Linux users.
> 
> I took some screenshots of the AudioMIDISetup app and of the content of
> the driver install packages. I don't if that can be of any help. You can
> see them here: http://ptitjes.free.fr/screenshots/
> 
> I don't know what step I should take know. Reinstalling drivers on OS X
> to see if there is any change ?

Ok, if you want to work on this, here are some ideas.

The first thing is that you need to understand how the driver and the
device communicate. It's probably some protocol that resembles to the
UAC standard in either version 1 or 2, but there has to be some
difference, otherwise the device would already be working.

You can do that by sniffing the packets on the wire, either with an USB
hardware analyzer or by some software tracer tool. Once you got a dump
of the setup phase and some seconds of streaming, you have to analyze
and reverse-egineer it.

As soon as you know where the differences are between the UAC standard
protocol that the generic Linux driver implements and the one your
device speaks is, you should share this information here so we can
discuss what would be a good way to teach the driver that protocol. In
some cases, the problem can be solved by simply adding a quirks entry
and override the descriptor set with some hard-coded values
(quirks-table.h). In other cases, the protocol code has to be tweaked by
adding special cases.

Unfortunately, in the case of your device, you would also need to
extract the firmware from the bitstream and add some functions to the
driver to do the download. Which is really sad and will be quite some
work to do.


Let me know of you make any progress here.


Daniel
