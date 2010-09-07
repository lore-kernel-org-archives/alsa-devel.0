From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
 is "Unknown"
Date: Tue, 7 Sep 2010 17:10:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009071709560.10278@eeebox2.perex-int.cz>
References: <1283357723.8159.4.camel@localhost.localdomain>
	<s5hmxs0zgxs.wl%tiwai@suse.de>
	<AANLkTinrEAooT1ZUnsxy+bA2CNtSAeOwOT1WSNdTL0o1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 26563244CD
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 17:10:28 +0200 (CEST)
In-Reply-To: <AANLkTinrEAooT1ZUnsxy+bA2CNtSAeOwOT1WSNdTL0o1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2010, Raymond Yau wrote:

> 2010/9/2 Takashi Iwai <tiwai@suse.de>
>
>> At Wed, 01 Sep 2010 18:15:23 +0200,
>> Pacho Ramos wrote:
>>>
>>> This is an old problem I am suffering since kernel-2.6.32 and that is
>>> still unresolved even with 2.6.35 and alsa-utils-1.0.23:
>>> http://www.spinics.net/lists/alsa-devel/msg31422.html
>>>
>>> If you follow the thread, it got stalled in:
>>> http://www.spinics.net/lists/alsa-devel/msg31433.html
>>>
>>> In summary, I get the following:
>>> # alsactl -f /etc/asound.state restore /dev/snd/controlC0
>>> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
>>> "0x1415"
>>> Hardware is initialized using a guess method
>>> # echo $?
>>> 99
>>
>> This is no error.  It means that alsactl has no special workaround
>> for your hardware.  The return code of alsactl looks strange.
>> I thought Jaroslav has already fixed it, though...
>>
>>
>> Takashi
>>
>>>
>>> As you can see, the exit code was solved, but I don't know why my
>>> hardware is still shown as "Unknown" even if
>>> via82xx.c clearly has some lines for my device:
>>>         SND_PCI_QUIRK(0x147b, 0x1415, "ABIT AV8", VIA_DXS_NO_VRA),
>>>
>>>
>>
>
>
> why "alsactl init" does not select "Mic" as "Capture Source" for AC97 codec
> ?
>
> it seem "alsactl init" does not set "Mic Boost" too

This patch should change the initial script to set these two controls:

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=52bd2f8acedaacce32ca8e89cb1f21683658648e

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
