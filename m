From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: ALC892,
 Clevo P150HM: Input Source gets reset to "Mic" every resume
Date: Fri, 02 Mar 2012 23:01:36 +0100
Message-ID: <4F514340.1010206@gmail.com>
References: <4EDA65A3.6090604@gmail.com>
	<CAN8cciamS8VF+27CCvoriU6T1_NfjSNYTJG1iXDHeLqW==MW+A@mail.gmail.com>
	<ji631h$sjt$1@dough.gmane.org> <s5h1upk4ldj.wl%tiwai@suse.de>
	<4F4809E2.1040305@gmail.com> <s5hty2f2p6i.wl%tiwai@suse.de>
	<4F51136C.6000107@gmail.com> <20120302184345.GA13598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B31B81039E7
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 23:01:38 +0100 (CET)
Received: by wiax18 with SMTP id x18so404834wia.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 14:01:38 -0800 (PST)
In-Reply-To: <20120302184345.GA13598@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

W dniu 02.03.2012 19:43, Greg KH pisze:
> On Fri, Mar 02, 2012 at 07:37:32PM +0100, Julian Sikorski wrote:
>> W dniu 25.02.2012 11:16, Takashi Iwai pisze:
>>> At Fri, 24 Feb 2012 23:06:26 +0100,
>>> Julian Sikorski wrote:
>>>>
>>>> W dniu 24.02.2012 10:43, Takashi Iwai pisze:
>>>>> At Thu, 23 Feb 2012 20:11:44 +0100,
>>>>> Julian Sikorski wrote:
>>>>>>
>>>>>> W dniu 09.12.2011 14:32, Raymond Yau pisze:
>>>>>>> 2011/12/4 Julian Sikorski <belegdol@gmail.com>:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> whenever I resume the machine, the Input Source would get changed back
>>>>>>>> from "Internal Mic" to "Mic". This is a bit annoying, because pulseaudio
>>>>>>>> is unaware of that change. As a result, everything looks fine in
>>>>>>>> pavucontrol but no sound gets recorded. A quick look at alsamixer -c0
>>>>>>>> revealed the problem. My alsa info:
>>>>>>>>
>>>>>>>> http://www.alsa-project.org/db/?f=c5776b615a5f3b9ae624e4250fb0c2b69118ce26
>>>>>>>>
>>>>>>>> This is unrelated to the other problems I have been reporting, since
>>>>>>>> this happens on a mostly-stock Fedora 3.1.2 kernel (the patch I added
>>>>>>>> deals with xhci, not alsa).
>>>>>>>
>>>>>>> The problem seem can be reproduced by using hda-emu,
>>>>>>> it is init_capsrc_for_pin() and alc_auto_init_input_src() write value
>>>>>>> to cache before snd_hda_codec_resume_app() from cache
>>>>>>>
>>>>>>>
>>>>>>>> get 28
>>>>>>> 28 Input Source:0
>>>>>>> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Mic]
>>>>>>>> set 28 1
>>>>>>> send: NID=0x23, VERB=0x360(set_amp_gain_mute,I:L#0), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x350(set_amp_gain_mute,I:R#0), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x0
>>>>>>> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x0
>>>>>>>> get 28
>>>>>>> 28 Input Source:0
>>>>>>> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Internal Mic]
>>>>>>>
>>>>>>> pm
>>>>>>> ** SUSPENDING **
>>>>>>> ...
>>>>>>> ** RESUMING **
>>>>>>> PM-Notified
>>>>>>> ...
>>>>>>> exec_init_verbs
>>>>>>> ...
>>>>>>>
>>>>>>> init_capsrc_for_pin 18
>>>>>>> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x0
>>>>>>> receive: 0x0
>>>>>>> send: NID=0x23, VERB=0xb00(get_amp_gain_mute,I:R#0), PARM=0x0
>>>>>>> receive: 0x0
>>>>>>> init capsrc for pin 19
>>>>>>> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x1
>>>>>>> receive: 0x80
>>>>>>> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x0
>>>>>>> send: NID=0x23, VERB=0xb00(get_amp_gain_mute,I:R#0), PARM=0x1
>>>>>>> receive: 0x80
>>>>>>> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x0
>>>>>>> init capsrc for pin 1a
>>>>>>> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x2
>>>>>>> receive: 0x80
>>>>>>> send: NID=0x23, VERB=0x362(set_amp_gain_mute,I:L#2), PARM=0x0
>>>>>>>
>>>>>>> alc_auto_init_input_src
>>>>>>> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x362(set_amp_gain_mute,I:L#2), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x352(set_amp_gain_mute,I:R#2), PARM=0x80
>>>>>>>
>>>>>>> snd_hda_codec_resume_app
>>>>>>> send: NID=0x23, VERB=0x363(set_amp_gain_mute,I:L#3), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x353(set_amp_gain_mute,I:R#3), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x364(set_amp_gain_mute,I:L#4), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x354(set_amp_gain_mute,I:R#4), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x365(set_amp_gain_mute,I:L#5), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x355(set_amp_gain_mute,I:R#5), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x366(set_amp_gain_mute,I:L#6), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x356(set_amp_gain_mute,I:R#6), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x367(set_amp_gain_mute,I:L#7), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x357(set_amp_gain_mute,I:R#7), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x368(set_amp_gain_mute,I:L#8), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x358(set_amp_gain_mute,I:R#8), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x369(set_amp_gain_mute,I:L#9), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x359(set_amp_gain_mute,I:R#9), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x36a(set_amp_gain_mute,I:L#10), PARM=0x80
>>>>>>> send: NID=0x23, VERB=0x35a(set_amp_gain_mute,I:R#10), PARM=0x80
>>>>>>> ...
>>>>>>>
>>>>>>>> get 28
>>>>>>> 28 Input Source:0
>>>>>>> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Mic]
>>>>>> The problem still exists in 3.2.7-1.fc16.x86_64 kernel, is there any
>>>>>> chance for a fix?
>>>>>
>>>>> Does the patch below fix?
>>>>>
>>>>>
>>>>> Takashi
>>>>
>>>> Yes, it seems so. I don't want to get ahead of myself, but two
>>>> suspend-resume cycles have passed and inputs are at Internal Mic and
>>>> Mic, as expected.
>>>
>>> Thanks for checking.  I committed the fix to git tree, also Cc'ed to
>>> stable.
>>>
>>>
>>> Takashi
>> I cannot seem to find this patch in the 3.2 stable tree, was it rejected?
> 
> What is the git commit id of it in Linus's tree?

Hmm, it does not seem to be in Linus' tree yet. It is in for-linus
branch of sound tree under commit 068b9394 though.

Julian
