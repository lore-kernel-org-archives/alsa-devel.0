From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PING!] Re: HDMI audio is not working on my new
	desktop
Date: Wed, 21 Aug 2013 12:12:37 +0600
Message-ID: <CAN_LGv3S8tDofB=jQ=9cu1wExizo37ac_qL2GBJvvz0pi3grPQ@mail.gmail.com>
References: <CAN_LGv1eGP=Krg_zRXhLhLVPv12dpybKj_fy+r=oS4nSnXRGCg@mail.gmail.com>
 <s5hbo4tmtn2.wl%tiwai@suse.de>
 <CA+v+29jhLVDHQ17TRTC3ZUW2g0b-mePQSWkCrLK95v_J5DggtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F5CC26080B
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 08:12:38 +0200 (CEST)
Received: by mail-qa0-f50.google.com with SMTP id o13so6339qaj.16
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 23:12:37 -0700 (PDT)
In-Reply-To: <CA+v+29jhLVDHQ17TRTC3ZUW2g0b-mePQSWkCrLK95v_J5DggtA@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

2013/8/21 Wang Xingchao <wangxingchao2011@gmail.com>:
> Hi Takashi/Alexander E. Patrakov,
>
> 2013/8/20 Takashi Iwai <tiwai@suse.de>:
>> Xingchao, could you take a look at this bug?
>
> sure, i will take a look at it.
> But i'm afraid i cannot continue tracking from next week, i'm under
> leaving process at Intel.

Best wishes to you, and good luck with a new job :)

But then please tell us the contact information of the person at Intel
who should be contacted instead of you for any further questions
related to HDMI audio on Haswell.

> At first glance, i saw a lot of errors:
>
> [  772.822663] playback write error (DMA or IRQ trouble?)
> [  782.912776] playback write error (DMA or IRQ trouble?)
> [  793.002904] playback write error (DMA or IRQ trouble?)
> [  803.093052] playback write error (DMA or IRQ trouble?)
> [  813.183205] playback write error (DMA or IRQ trouble?)
> [  823.273217] playback write error (DMA or IRQ trouble?)
>
> I know this issue on some Haswell ULT boards(STP/WTM1) because they
> are not stable, and it's better to use latest BIOS image(V131 or
> later).

Thanks, I will try to update the BIOS and retest.

> And seems the proper HDMI device should be pin6, i hope Alexander E.
> Patrakov could help check below command at first:
> speak-test -t wav -c 2 -D hw:0,7

Same result. I guess I should update the BIOS first.

> And pleaset let me know can you reproduce this issue 100% on the same
> board? Did you test on some other boards with same Hardware?

The issue is 100% reproducible on my board, and I don't have any other
Haswell boards to test.

-- 
Alexander E. Patrakov
