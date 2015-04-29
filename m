From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Wed, 29 Apr 2015 22:26:39 +0200
Message-ID: <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 5693D2606C3
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 22:27:00 +0200 (CEST)
Received: by widdi4 with SMTP id di4so194105456wid.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:27:00 -0700 (PDT)
In-Reply-To: <s5h618e92w5.wl-tiwai@suse.de>
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

>> I'm having issues with the internal microphone on an Asus R553 (or S551) laptop.
>>
>> With the boost set to zero the microphone works but the level of the
>> recording is very low.
>> If I try another boost setting I don't get any signal anymore.

> The problem is unlikely specific to the codec (ALC3236) but the whole
> hardware implementation.

I have to admit that I have zero knowledge of how these things are
implemented. I can't find a datasheet for that codec anywhere.
However, looking at the ALC262 datasheet for instance, the block
diagram represents the boost function inside the codec itself.

> Your hardware seems to have only one mic pin.  It's already strange.
> Usually there are two mic pins.  Did you try the input from mic jack
> (or headset mic)?   Did it work with mic boot volume properly?

I just tried : plugging a headset in the combo jack does not seem to
have any effect on the mic input. It seems that the mic on the headset
is not used, and that the internal microphone of the laptop is still
active.

   Simon
