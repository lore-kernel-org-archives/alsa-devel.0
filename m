From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Shared volume control again
Date: Thu, 30 Oct 2014 09:18:41 +0800
Message-ID: <CAN8cciYc8586KP9B2m8=Axv_w5BXc5Q6VJK3aFwi23E3oa_UKQ@mail.gmail.com>
References: <s5hegtq6c8d.wl-tiwai@suse.de>
	<54511FEE.40906@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFC12604F3
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 02:18:42 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id m20so3499827qcx.30
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:18:41 -0700 (PDT)
In-Reply-To: <54511FEE.40906@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> thinking of the problem about shared volume controls again, I stumbled
>> on a case where your suggested solution doesn't work well.  Namely,
>> when a headphone volume is shared for two headphones (one on the
>> laptop and one on the dock), how should it be named?  One is
>> "Headphone" and another is "Dock Headphone".  That's a bit tricky.
>>
>> So, in the end, we need the mapping representation somehow more
>> explicitly than the control name.
>>
>> Thoughts?
>
>
> In practice, it seems like we more often than not share DAC for all
headphones. Also it is very common today that a jack called "Front
Headphone" has a volume control called only "Headphone".
>
> That's the status quo. As a result we have only one headphone path in
PulseAudio for all types of headphones.
> And it kind of works as long as we *always* share DAC between the
different headphones.

it is unlikely that dual headphone jacks share DAC on those Dell XPS
notebook with 8 channels hda codec

Surround 40 should not be supported when headphone and dock headphone
always share DAC

Are there any difference when dock station has dock line out instead of
dock headphone?

Another ad hoc case is asus g75 with vt1802 which have speaker and
subwoober,  headohone and speaker share DAC so that the subwoofer can have
volume control

For Dell alienware notebook with alc668,  headset and headphone jack, mic
jack internal 2.1 speaker

User expect the headset jack default to be used as headset since the
notebook has another headphone jack
