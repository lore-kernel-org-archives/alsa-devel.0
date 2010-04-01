From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Fri, 02 Apr 2010 00:52:27 +0300
Message-ID: <hp34j2$fn6$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>	<hm8cus$56i$1@dough.gmane.org>	<1267193154.29204.0.camel@localhost.localdomain>	<4f3252891002271729p6eb66724v62ce97ea9a6eb577@mail.gmail.com>	<hohr62$f78$1@dough.gmane.org>	<4f3252891003280552y29015aeav7b68e9972371325b@mail.gmail.com>	<hooi7i$fd4$1@dough.gmane.org>	<4f3252891003281810r38e61306w83ebfe9ad2b8c69f@mail.gmail.com>	<hopn7r$cul$1@dough.gmane.org>
	<z2i4f3252891004010705h8dfe2f71q20de60626a9b8941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id A8EFB103807
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 23:52:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NxSJn-00043i-BX
	for alsa-devel@alsa-project.org; Thu, 01 Apr 2010 23:52:51 +0200
Received: from 212.73.151.246 ([212.73.151.246])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2010 23:52:51 +0200
Received: from fn42551 by 212.73.151.246 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2010 23:52:51 +0200
In-Reply-To: <z2i4f3252891004010705h8dfe2f71q20de60626a9b8941@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> 2010/3/29 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
> =

>> Raymond Yau wrote:
>>
>>> 2010/3/29 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
>>>
>>>  Raymond Yau wrote:
>>>>> 2010/3/26 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
>>>>>
>>>>>  Hello again!
>>>>>> I've recently had some time to investigate this problem further on a=
nd
>>>>>> here's what I've discovered:
>>>>>>
>>>>>> Raymond Yau wrote:
>>>>>>
>>>>>>> 2010/2/26 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
>>>>>>>
>>>>>>>  El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=F3:
>>>>>>>>> Raymond Yau wrote:
>>>>>>>>>
>>>>>>>>>> 2010/2/25 Jaroslav Kysela <perex@perex.cz>
>>>>>>>>>>
>>>>>>>>>>  On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>>>>>>>>  Jaroslav Kysela wrote:
>>>>>>>>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>  Hello,
>>>>>>>>>>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a
>>>>>>>>>>>>>>
>>>>>>>>>>>>> built-in
>>>>>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller
>>>>>>>>>>>>> (rev
>>>>>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
>>>>>>>>>>>>>> Controller] (rev 03) -- and get the following message:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84"
>>>>>>>>>>>>>>
>>>>>>>>>>>>> "AC97a:83847600"
>>>>>>>>> "0x1073" "0x000d"
>>>>>>>>>>>>>> Hardware is initialized using a guess method
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> As a consequence the volume levels of the Yamaha card do not
>>>>>>>>>>>>>> get
>>>>>>>>>>>>>> restored to the levels stored in /etc/asound.state.  The vol=
ume
>>>>>>>>>>>>>>
>>>>>>>>>>>>> levels
>>>>>>>>> of the built-in card however are properly restored.  The
>>>>>>>>>>>>> asound.state
>>>>>>>>> file has been created by executing 'alsactl store'.
>>>>>>>>>>>>>>  your problem is "alsactl restore" become "alsactl init" when
>>>>>>> the number
>>>>>>>
>>>>>> of
>>>>>>
>>>>>>> controls is more than those in state file.
>>>>>>>
>>>>>> I'm not quite sure that the case is this since 'alsactl restore' does
>>>>>> restore the values of the Yamaha sound card (and those of the other
>>>>>> card, too) and 'alsactl restore 1' seems to just initialize the Yama=
ha
>>>>>> card.  This is with alsa-utils version 1.0.22.
>>>>>>
>>>>>>  "Hardware is initialized using a guess method "  is the message used
>>>>> by
>>>>> alsactl init
>>>>>
>>>>>
>>>>>
>>>> http://git.alsa-project.org/?p=3Dalsa-utils.git;a=3Dcommitdiff;h=3D9a7=
48178d1c9e783242f0cc794ab3efb27092f34;hp=3D0c02a4e3d23c7b5d03215f1bfaba9f70=
ed11e9b7
>>>>
>>>> I don't get what you mean. Could you explain a little bit more?
>>>>
>>>>  post the output of alsa-info.sh after  "alsactl init"
>>> and immeditate after the system boot
>>>
>> I'm sending the requested output as an attachment.
> =

> As you can see the driver has 79 controls but only 48 controls saved in t=
he
> asound.state
> =

> that is why "alsactl restore" become "alsactl init"
> =

> =

> !!Amixer output
> !!-------------
> =

> !!-------Mixer controls for card 0 [YMF724F]
> =

> Card hw:0 'YMF724F'/'Yamaha DS-1 (YMF724F) at 0xfb000000, irq 5'
>   Mixer name    : 'SigmaTel STAC9700,83,84'
>   Components    : 'AC97a:83847600'
>   Controls      : 79
>   Simple ctrls  : 31

My question was why 'alsactl restore' restores the sound card and =

'alsactl restore 1' just initializes the card.

Angel Tsankov
