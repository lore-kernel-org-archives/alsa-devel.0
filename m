From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Tue, 4 Dec 2012 10:48:47 +0800
Message-ID: <CAN8ccibjt12hMEi=p4kJob1ZtsCHHoySTe73Ttj4xHEKfdnGMQ@mail.gmail.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
 <50B7FED7.4030900@canonical.com> <s5ha9tz4j6z.wl%tiwai@suse.de>
 <50B87265.60509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BDBD72617A9
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 03:48:48 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id k14so5116390iea.38
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2012 18:48:47 -0800 (PST)
In-Reply-To: <50B87265.60509@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>>>> HP Z220 with ALC221 codec has a front jack that should work as both
>>>> the front mic and the secondary headphone.  This patch adds a new
>>>> mixer enum to change the jack behavior.

>>
>>> I would recommend a user to use hda-jack-retask in these cases, instead
>>> of cluttering the kernel code.
>>
>>
>> Well, hda-jack-retask is a nice debugging tool, but it's not intended
>> for the actual user interface for daily use.
>
>
> Maybe we should consider making the reconfiguration more lightweight in
the kernel then, so that hda-jack-retask (or a more simplistic GUI) can be
used for daily use?
>

only idt and realtek support dual headphones

the user are unlikely to use hda-jack-retask on the other hda codecs.
via driver hardcode the headphone pin in widget set power state function

>
>> Also, a big missing
>> piece is the automatic retasking via jack detection as a headphone.
>
>

>
> This might work for this particular case, but sounds like it could become
a confusing set of alsa-mixer controls (and hairy kernel code to control
them all!) - e g, what if two jacks that currently are not headphones both
want to be headphones, and they have independent volume controls? Which one
will be controlled by "Headphone Volume"?

http://www.alsa-project.org/db/?f=3cd5e75a351b4602609f7c478977cdb96d61c627

seem no headphone playback volume on z220 , line out and headphone share
pcm playback volume and the mono speaker own speaker volume control

it is confusing when auto mic selection co exist with alt_capture device
