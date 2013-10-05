From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PING!] Re: HDMI audio is not working on my new
	desktop
Date: Sat, 5 Oct 2013 18:19:06 +0600
Message-ID: <CAN_LGv1vJn8awr4hEOA8HfJkBHhOMVfLbUUXuJqcmytSSX2YFQ@mail.gmail.com>
References: <CAN_LGv1eGP=Krg_zRXhLhLVPv12dpybKj_fy+r=oS4nSnXRGCg@mail.gmail.com>
 <s5hbo4tmtn2.wl%tiwai@suse.de>
 <CA+v+29jhLVDHQ17TRTC3ZUW2g0b-mePQSWkCrLK95v_J5DggtA@mail.gmail.com>
 <CAN_LGv3S8tDofB=jQ=9cu1wExizo37ac_qL2GBJvvz0pi3grPQ@mail.gmail.com>
 <CA+v+29jcG-F=wpFcREfo50T9gJkaz-JXxUXYKbFZdH_9CqSSFg@mail.gmail.com>
 <CAN_LGv0jJu3x_N3=C-8Bbvi8mV_tW1x1YW2dA5Nw88zKdHqMvA@mail.gmail.com>
 <CAN_LGv2OGfV-PaTHRBbvmsD+R_jdZh1JYcs4+Mi2evJ=tw1YzA@mail.gmail.com>
 <CAN_LGv3uaUjk2g8NEVgmU+aghBBHA7ay27uhvjhLb_+K59vPuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0AA2610B8
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 14:19:08 +0200 (CEST)
Received: by mail-qc0-f175.google.com with SMTP id v2so3553412qcr.6
 for <alsa-devel@alsa-project.org>; Sat, 05 Oct 2013 05:19:07 -0700 (PDT)
In-Reply-To: <CAN_LGv3uaUjk2g8NEVgmU+aghBBHA7ay27uhvjhLb_+K59vPuw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <wangxingchao2011@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, broonie@kernel.org, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

2013/10/5 Alexander E. Patrakov <patrakov@gmail.com>:
> 2013/9/5 Alexander E. Patrakov <patrakov@gmail.com>:
>> 2013/8/22 Alexander E. Patrakov <patrakov@gmail.com>:
>>> 2013/8/22 Wang Xingchao <wangxingchao2011@gmail.com>:
>>>> cc Mengdong and Liam, we're in the same PRC audio Team.
>>>>
>>>> 2013/8/21 Alexander E. Patrakov <patrakov@gmail.com>:
>>>>> 2013/8/21 Wang Xingchao <wangxingchao2011@gmail.com>:
>>>>>> Hi Takashi/Alexander E. Patrakov,
>>>>>>
>>>>>> 2013/8/20 Takashi Iwai <tiwai@suse.de>:
>>>>>>> Xingchao, could you take a look at this bug?
>>>>>>
>>>>>> sure, i will take a look at it.
>>>>>> But i'm afraid i cannot continue tracking from next week, i'm under
>>>>>> leaving process at Intel.
>>>>>
>>>>> Best wishes to you, and good luck with a new job :)
>>>>>
>>>>> But then please tell us the contact information of the person at Intel
>>>>> who should be contacted instead of you for any further questions
>>>>> related to HDMI audio on Haswell.
>>>>>
>>>>>> At first glance, i saw a lot of errors:
>>>>>>
>>>>>> [  772.822663] playback write error (DMA or IRQ trouble?)
>>>>>> [  782.912776] playback write error (DMA or IRQ trouble?)
>>>>>> [  793.002904] playback write error (DMA or IRQ trouble?)
>>>>>> [  803.093052] playback write error (DMA or IRQ trouble?)
>>>>>> [  813.183205] playback write error (DMA or IRQ trouble?)
>>>>>> [  823.273217] playback write error (DMA or IRQ trouble?)
>>>>>>
>>>>>> I know this issue on some Haswell ULT boards(STP/WTM1) because they
>>>>>> are not stable, and it's better to use latest BIOS image(V131 or
>>>>>> later).
>>>>
>>>> btw, did you do any suspend/resume operation before the audio playback test?
>>>> if not, it's a new case. i found the issue only on some particular
>>>> boards after suspend/resume.
>>>
>>> The issue is 100% reproducible without suspend/resume. Just in case, I
>>> tested after one suspend-resume cycle, it didn't fix the problem.
>>
>> On IRC (#intel-gfx) ohsix said that the bug
>> (https://bugzilla.kernel.org/show_bug.cgi?id=60769) may be graphics
>> related after all, but was too scared with the interrupt handling code
>> there. The contents of /proc/interrupts are attached to the bug, but
>> he said there is nothing interesting there.
>>
>> BTW I am surprised that the bug is still assigned to Jaroslav Kysela
>> and not to Intel specialists (who are not even in the CC list of the
>> bug).
>>
>> --
>> Alexander E. Patrakov
>
> broonie@kernel.org asked to CC: him to the thread. As far as I know,
> Intel tried to reproduce this bug on their hardware and on some OEM
> boards, but didn't try exactly the same motherboard, and reproduced
> another bug (files play silently but IRQs seem to come correctly).
>
> It is interesting to know that today I found two people on FreeNode
> IRC with the same board, and only one of them (rvalles) can reproduce
> the IRQ problem. The other one (broonie) uses an older kernel
> (Debian's 3.10-3, current unstable) and sees the "files play silently"
> problem instead of the IRQ one.
>
> --
> Alexander E. Patrakov

I have tried the Debian kernel on my Gentoo system and... HDMI audio
works (but always plays both in the Dell monitor and the LG TV
simultaneously). So this is a regression, will bisect.

-- 
Alexander E. Patrakov
