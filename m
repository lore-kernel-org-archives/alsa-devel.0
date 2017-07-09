From: Damien Zammit <damien@zamaudio.com>
Subject: Re: Patch for Digidesign Mbox 2 (set sample rate)
Date: Sun, 9 Jul 2017 12:14:13 +1000
Message-ID: <8ff1733e-3ff5-0ba4-ebfa-866797ca35bf@zamaudio.com>
References: <CANx-tGgQ59u==FL-yAvR6QRZWZp7LNgU4Qaf6EQ45Ae8t-=VWw@mail.gmail.com>
 <s5h1ss6s0t9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3CB26648D
 for <alsa-devel@alsa-project.org>; Sun,  9 Jul 2017 04:14:19 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id c24so9726698pfe.1
 for <alsa-devel@alsa-project.org>; Sat, 08 Jul 2017 19:14:19 -0700 (PDT)
In-Reply-To: <s5h1ss6s0t9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Viktor Radnai <viktor.radnai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I have tested Viktor's patch on "Mbox 2" and it works very well.
Looks like my 'magic' boot sequence was not needed.
Rate switching works between 44.1 and 48k.
Good job.

Damien

On 03/05/17 20:16, Takashi Iwai wrote:
> On Fri, 28 Apr 2017 22:36:09 +0200,
> Viktor Radnai wrote:
>>
>> Hi there,
>>
>> I have recently bought a Digidesign Mbox 2 Mini and found the lack of
>> support for 44100Hz sample rate in the driver limiting (the sample rate was
>> hard-set to 48000Hz by the original author even though the device supports
>> it, because he couldn't get the frame rate switching to work reliably).
>>
>> I had a go at hacking the driver and came up with the following patch which
>> appears to work on the MBox 2 Mini:
>> https://pastebin.com/kzzTDj9T
>>
>> I have built and tested this with Linux 4.8.15 without any realtime
>> patches. I am planning to pick up a "full size" Mbox 2 as well, in the
>> meantime if anyone on the list owns one I would appreciate if you could
>> test this and let me know the result. There is a possibility that it will
>> not work without the "magic" init sequence that I have removed because it
>> does not look like it's needed on the Mini. Although I would be a bit
>> surprised because the two devices are apparently identical to the point
>> that the Mini allows the use of it's physically nonexistent features.
>>
>> Once someone could confirm that this works, I would like to get it merged.
>> This is my first attempt at submitting a patch for any Linux device driver
>> so please let me know if I need to do anything else :)
> 
> At least it'd be better to the original author in the loop.
> Damien, could you take a look if you still have the device?
> 
> 
> thanks,
> 
> Takashi
> 
