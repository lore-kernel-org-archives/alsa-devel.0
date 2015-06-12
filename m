From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 17:40:28 +0800
Message-ID: <CAN8ccibEg_gN_xM0boY=Ob+ahid66GsqBwHLs97sW8C7mgc4Dg@mail.gmail.com>
References: <5576B419.5010505@canonical.com> <s5h1thlqeus.wl-tiwai@suse.de>
 <5576E994.2080300@canonical.com> <5577BAEE.50506@canonical.com>
 <s5h1thjoo14.wl-tiwai@suse.de> <s5hoakmjn6i.wl-tiwai@suse.de>
 <557A7718.5070100@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B8E04266815
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 11:40:29 +0200 (CEST)
Received: by obbsn1 with SMTP id sn1so19980168obb.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 02:40:28 -0700 (PDT)
In-Reply-To: <557A7718.5070100@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, lukasz.wojnilowicz@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, hwang4 <hui.wang@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 OK, good to know. I'd like to test a bit more via hda-emu whether this
>>> gives any ill effects. So far, this seems fixing a few other machines, too,
>>> so it's a good thing to have in general.
>>>
>> This change alone results in regressions on machines that are capable
>> of 4.0/5.1 surrounds.  For avoiding it, the badness for multi-io has
>> to be increased as well.  It's damn sensitive.
>>
>> But, now I wonder now whether blindly applying this is good.  Suppose
>> a machine with 2.1 speaker and one headphone, but the codec has only
>> two DACs.  With this setup, now the headphone and the speaker share
>> the same DAC, as the cost of having individual 2.1 speaker volume.
>> Is this more useful than having individual volumes for speaker and
>> headphone?
>>
>> Maybe the machine you're trying to support has a different situation.
>> So applying the new rule to limited devices is fine.  But if so, it's
>> not necessarily to be an adjustment of badness table, but just you can
>> provide the simple DAC/pin preference map explicitly in the fixup.
>>
>
> Oh, this is an interesting trade-off.
>
> In the PulseAudio desktop scenario, we automute the speaker, and
> PulseAudio remembers the individual headphone and speaker volumes. So in
> this case, there is no benefit from having individual headphone and speaker
> volume at the ALSA level.
>
> However if a user wants to turn off automute, then there is a need for
> being able to adjust headphone and speaker volume individually.
>

Do "front Playback volume" a good name when volume control is shared by
headphone and speaker" ?

in desktop with alc66x , volume control shared by headphone and Line Out is
name as "Front" because it support 5.1

>
> But it's not just a question of volume control for 2.1. Being able to send
> a different stream to the subwoofer could be useful too, especially if the
> hardware filter is bad or non-existing.
>

when subwoofer is using stereo pin complex (usually with 6, 8 or 10
channels codec), only one left or right channel is used (e.g. Asus N series
note book external sonic master subwoofer use right channel but acer aspire
5930g internal subwoofer using left channel

FL, FR LFE N/A
FL, FR, N/A, LFE

how do pulseaudio perform lfe filter when subwoofer is using mono pin
since the downmix widget mix left and right channel and scale down the
volume ?

FL, FR, LFE, LFE

do it need more CPU than those use one channel of stereo pin complex

For those 2 channel hda codec 's subwoofer must use mono pin

>
>
>
