From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Constant headphone noise on Dell XPS 13 9365
Date: Thu, 22 Jun 2017 19:11:03 -0500
Message-ID: <CAMP44s1Uj8XR60pDH-Qz84XB=pVH1rhA6Ou_XEqJVPJ7-f1waw@mail.gmail.com>
References: <CAMP44s000FA3BAQEwqxPQxUGeR4U=PhByJfAAA9q74M8=6iTyQ@mail.gmail.com>
 <s5h1sr4dh3w.wl-tiwai@suse.de>
 <CAMP44s1tQ0Ss21v1OuyFWS3CtpQzO8Qid+Q8GcE0x9VFc=DPJA@mail.gmail.com>
 <s5htw40bznn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 872E8266DB8
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 02:11:05 +0200 (CEST)
Received: by mail-vk0-f66.google.com with SMTP id p62so885425vkp.0
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 17:11:05 -0700 (PDT)
In-Reply-To: <s5htw40bznn.wl-tiwai@suse.de>
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

On Wed, May 31, 2017 at 2:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 31 May 2017 20:56:53 +0200,
> Felipe Contreras wrote:
>>
>> On Wed, May 31, 2017 at 1:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> > Is there "Loopback Mixer" switch?  If yes and it's on, try to turn it
>> > off.  The analog loopback is often the source of the unknown noise.
>>
>> Yes, "Loopback Mixing". it was off.
>>
>> > Other than that, try to apply the existing quirks.  Some of them are
>> > applicable via model option of snd-hda-intel module.
>>
>> Which quirks should I try?
>
> Check your codec chip, and then see which model option is available.

It's a Realtek ALC3271. I don't see any model options available for
this, but I checked the code and it has the same codec vendor ID as
ALC269 so I tried all the model fixups I saw in alc269_fixup_models
with no luck.

However, I noticed something interesting; when I enabled the
"dell-headset-dock" fixup, the noises got louder, and I noticed a
pattern. It seems everything else I do in the laptop results in a
noise; moving the mouse, pressing a key on the keyboard, even a cursor
blinking on the screen results in a distinguishable noise. After a
while the noises lower in volume, as before, but the patter is still
there, is just that I hadn't noticed.

Any ideas?

-- 
Felipe Contreras
