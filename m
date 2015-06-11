From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Thu, 11 Jun 2015 19:37:58 +0300
Message-ID: <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f195.google.com (mail-lb0-f195.google.com
 [209.85.217.195])
 by alsa0.perex.cz (Postfix) with ESMTP id AFC3726657D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:37:58 +0200 (CEST)
Received: by lbdu14 with SMTP id u14so2965147lbd.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 09:37:58 -0700 (PDT)
In-Reply-To: <s5h616ul6o5.wl-tiwai@suse.de>
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

Hi,

The laptop has 3 jacks. 5.1/4.0 works fine in Windows 8.1 and I'm not
talking about HDMI/SPDIF.
If you look at the laptop specification, it says
1 x Microphone-in jack
2 x Headphone-out jack (SPDIF)
But the microphone-in jack can also be an output.
Also, the laptop has two microphones, a pair of speakers and a subwoofer (?)
I can also boot Windows and provide information, please let me know
what you need.

Best regards,
Nicolae Rosia

On Thu, Jun 11, 2015 at 4:24 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 10 Jun 2015 22:43:49 +0300,
> Nicolae Rosia wrote:
>>
>> > Could you give alsa-info.sh output?
>> >
>> > The first thing you should check is whether all jacks are properly
>> > recognized as output pins.  You can check the jack detection via
>> > hdajackretask or other programs and make 1:1 mapping between pin and
>> > jack.  Let us know the result.
>> >
>> >
>> > Takashi
>>
>> Yes. http://www.alsa-project.org/db/?f=50db7d46bff0178ca661c6c5b82e2bce95d80b0a
>
> According to BIOS setup, the laptop has only one output jack one mic
> jack.  What do you suppose to make 4.0 or 5.1 outputs working with
> them?  Or do you mean about the surround outputs over HDMI or SPDIF?
>
> Please clarify what you exactly tested and what didn't work in more
> details.
>
>
> Takashi
