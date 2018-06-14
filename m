From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2 0/4] ALSA: usb-audio: Insertion Control
	for BADD Adaptors.
Date: Thu, 14 Jun 2018 22:18:10 +0300
Message-ID: <CAB=otbRkXJwMUXebJuLtVaZkUG-RY=O65rRNT9oL+u2_cipgXQ@mail.gmail.com>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
 <s5ha7rx2vya.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 190552673CC
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 21:18:11 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so7574829wro.0
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 12:18:11 -0700 (PDT)
In-Reply-To: <s5ha7rx2vya.wl-tiwai@suse.de>
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
Cc: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2018 at 7:07 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 14 Jun 2018 16:05:54 +0200,
> Jorge Sanjuan wrote:
>>
>> Thanks for review!
>>
>> Here is what's new in this V2:
>>  - Split the patchset into a more sensible series.
>>
>> This patchset adds support for the Insertion Control for BADD devices
>> (subset of UAC3).
>>
>> This control is only pressent in the HEADSET ADAPTER BADD profile. The USB
>> interrupt pipe shall be present for this profile so the status pipe
>> creation should also happen for BADD devices.
>>
>> Also, the bi-directional type codes have been defined so they can be used
>> as inferred values for the Input and Output terminals for this adapter
>> profile.
>>
>> Based on tag: next-20180612
>>
>> Jorge Sanjuan (4):
>>   ALSA: usb-audio: Add bi-directional terminal types.
>>   ALSA: usb-audio: Change in connectors control creation interface
>>   ALSA: usb-audio: UAC3. Add insertion control for BADD.
>>   ALSA: usb-audio: Always create the interrupt pipe for the mixer
>
> Thanks, this looks nicer, each of changes is smaller and clearer.
> Although it's a bit too late for the merge window, this is a change
> that is fairly safe for the existing UAC1/UAC2, I merged it now.
>

It's too late probably, but I just finished reviewing these patches
and don't have any objections.

Thanks,
Ruslan
