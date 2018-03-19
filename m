From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v1 0/6] ALSA: usb: UAC3. Add support for
 Basic Audio Device (BADD)
Date: Mon, 19 Mar 2018 03:51:10 +0200
Message-ID: <CAB=otbTk4-bv42A6DvtW83Ld38PF17VdK4AJ3acyS_sddxXxcw@mail.gmail.com>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
 <s5hy3lz3vjn.wl-tiwai@suse.de>
 <af8552b9-09d6-90db-c9c4-681c0d027815@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0289F267205
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 02:51:11 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id t2-v6so6526061otj.4
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 18:51:11 -0700 (PDT)
In-Reply-To: <af8552b9-09d6-90db-c9c4-681c0d027815@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, ci005-internal@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 19, 2017 at 11:46 AM, Jorge <jorge.sanjuan@codethink.co.uk> wrote:
>
>
> On 19/12/17 09:40, Takashi Iwai wrote:
>>
>> On Tue, 19 Dec 2017 10:14:05 +0100,
>> Jorge Sanjuan wrote:
>>>
>>>
>>> This adds functionality for the Basic Audio Device (BADD) subset that is
>>> defined in the USB Audio Class 3 (UAC3). In a BADD compliant driver, all
>>> Class Specific descriptors are inferred and so they should all be
>>> generated
>>> in the *host* as the device wont expose those. This also applies to the
>>> new
>>> HIGH CAPABILITY descriptor as the GET request is not to be supported in
>>> a BADD compliant driver.
>>>
>>> The new class requires the device to have 3 usb configurations as
>>> follows:
>>>
>>>      1: Legacy Mode: UAC1 or UAC2.
>>>      2: BADD device with a prefined topology. (Minimum).
>>>      3: UAC3 device for more detailed description or more complex
>>>         devices that can't be covered by the BADD profile.
>>>
>>> This patch series also includes some minor fixes to sound/usb.
>>>
>>> It has been tested with an actual UAC3 compliant device in different host
>>> machines and all configs (UAC1/2, BADD and UAC3) work.
>>>
>>> Also, this has been implemented on top of the the patch which adds UAC3
>>> support
>>> to the usb sound card driver:
>>>
>>>         commit ddd452d7b04b86fb5f9285a19ac54deca9264ac1
>>>         Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>>>         Date:   Tue Nov 7 04:01:20 2017 +0200
>>
>>
>> Where did you get this commit at all...?  The UAC3 patchset has never
>> been merged yet.  So it's moot for developing the stuff on top of it.
>> Or at least coordinate with Ruslan for merging into his series for the
>> next review round.
>
>
> Sorry. I meant to reference this patch:
>
> https://patchwork.kernel.org/patch/10045619/
>
> I had that commit message in our internal dev-branch after applying.
>
>>
>> Ruslan, can you revise the patchset addressing the issues, and
>> resubmit?

I've just sent v2, but it doesn't include this patchset as I'm currently
looking if it will be easier to update alsa structures directly rather
then generating full set of descriptors for such devices with inferred
class-specific descriptors. Will update you soon.

Thanks,
Ruslan


>>
>>
>> thanks,
>>
>> Takashi
>>
>>>
>>> Jorge Sanjuan (6):
>>>    usb: audio: Add bi-directional terminal types.
>>>    usb: audio: Fix variable length field to be variable.
>>>    ALSA: usb: UAC3. Add initial mixer support.
>>>    ALSA: usb: Only get AudioControl header for UAC1 class.
>>>    ALSA: usb: Use Class Specific EP for UAC3 devices.
>>>    ALSA: usb: ADC3: Add initial BADD spec support
>>>
>>>   include/linux/usb/audio-v3.h   |   2 +-
>>>   include/uapi/linux/usb/audio.h |  21 +-
>>>   sound/usb/Makefile             |   3 +-
>>>   sound/usb/badd.c               | 518
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   sound/usb/badd.h               |  14 ++
>>>   sound/usb/card.c               |  25 +-
>>>   sound/usb/mixer.c              |  24 ++
>>>   sound/usb/stream.c             | 165 ++++++++-----
>>>   sound/usb/usbaudio.h           |   1 +
>>>   9 files changed, 702 insertions(+), 71 deletions(-)
>>>   create mode 100644 sound/usb/badd.c
>>>   create mode 100644 sound/usb/badd.h
>>>
>>> --
>>> 2.11.0
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>



-- 
Best regards,
Ruslan Bilovol
