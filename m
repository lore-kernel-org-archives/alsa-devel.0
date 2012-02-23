From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: ALC892,
 Clevo P150HM: Input Source gets reset to "Mic" every resume
Date: Thu, 23 Feb 2012 20:11:44 +0100
Message-ID: <ji631h$sjt$1@dough.gmane.org>
References: <4EDA65A3.6090604@gmail.com>
	<CAN8cciamS8VF+27CCvoriU6T1_NfjSNYTJG1iXDHeLqW==MW+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 111B62436E
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 20:12:00 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1S0e56-000719-Ng
	for alsa-devel@alsa-project.org; Thu, 23 Feb 2012 20:11:56 +0100
Received: from 178-83-207-35.dynamic.hispeed.ch ([178.83.207.35])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 20:11:56 +0100
Received: from belegdol by 178-83-207-35.dynamic.hispeed.ch with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 20:11:56 +0100
In-Reply-To: <CAN8cciamS8VF+27CCvoriU6T1_NfjSNYTJG1iXDHeLqW==MW+A@mail.gmail.com>
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

W dniu 09.12.2011 14:32, Raymond Yau pisze:
> 2011/12/4 Julian Sikorski <belegdol@gmail.com>:
>> Hi,
>>
>> whenever I resume the machine, the Input Source would get changed back
>> from "Internal Mic" to "Mic". This is a bit annoying, because pulseaudio
>> is unaware of that change. As a result, everything looks fine in
>> pavucontrol but no sound gets recorded. A quick look at alsamixer -c0
>> revealed the problem. My alsa info:
>>
>> http://www.alsa-project.org/db/?f=c5776b615a5f3b9ae624e4250fb0c2b69118ce26
>>
>> This is unrelated to the other problems I have been reporting, since
>> this happens on a mostly-stock Fedora 3.1.2 kernel (the patch I added
>> deals with xhci, not alsa).
> 
> The problem seem can be reproduced by using hda-emu,
> it is init_capsrc_for_pin() and alc_auto_init_input_src() write value
> to cache before snd_hda_codec_resume_app() from cache
> 
> 
>> get 28
> 28 Input Source:0
> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Mic]
>> set 28 1
> send: NID=0x23, VERB=0x360(set_amp_gain_mute,I:L#0), PARM=0x80
> send: NID=0x23, VERB=0x350(set_amp_gain_mute,I:R#0), PARM=0x80
> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x0
> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x0
>> get 28
> 28 Input Source:0
> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Internal Mic]
> 
> pm
> ** SUSPENDING **
> ...
> ** RESUMING **
> PM-Notified
> ...
> exec_init_verbs
> ...
> 
> init_capsrc_for_pin 18
> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x0
> receive: 0x0
> send: NID=0x23, VERB=0xb00(get_amp_gain_mute,I:R#0), PARM=0x0
> receive: 0x0
> init capsrc for pin 19
> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x1
> receive: 0x80
> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x0
> send: NID=0x23, VERB=0xb00(get_amp_gain_mute,I:R#0), PARM=0x1
> receive: 0x80
> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x0
> init capsrc for pin 1a
> send: NID=0x23, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x2
> receive: 0x80
> send: NID=0x23, VERB=0x362(set_amp_gain_mute,I:L#2), PARM=0x0
> 
> alc_auto_init_input_src
> send: NID=0x23, VERB=0x361(set_amp_gain_mute,I:L#1), PARM=0x80
> send: NID=0x23, VERB=0x351(set_amp_gain_mute,I:R#1), PARM=0x80
> send: NID=0x23, VERB=0x362(set_amp_gain_mute,I:L#2), PARM=0x80
> send: NID=0x23, VERB=0x352(set_amp_gain_mute,I:R#2), PARM=0x80
> 
> snd_hda_codec_resume_app
> send: NID=0x23, VERB=0x363(set_amp_gain_mute,I:L#3), PARM=0x80
> send: NID=0x23, VERB=0x353(set_amp_gain_mute,I:R#3), PARM=0x80
> send: NID=0x23, VERB=0x364(set_amp_gain_mute,I:L#4), PARM=0x80
> send: NID=0x23, VERB=0x354(set_amp_gain_mute,I:R#4), PARM=0x80
> send: NID=0x23, VERB=0x365(set_amp_gain_mute,I:L#5), PARM=0x80
> send: NID=0x23, VERB=0x355(set_amp_gain_mute,I:R#5), PARM=0x80
> send: NID=0x23, VERB=0x366(set_amp_gain_mute,I:L#6), PARM=0x80
> send: NID=0x23, VERB=0x356(set_amp_gain_mute,I:R#6), PARM=0x80
> send: NID=0x23, VERB=0x367(set_amp_gain_mute,I:L#7), PARM=0x80
> send: NID=0x23, VERB=0x357(set_amp_gain_mute,I:R#7), PARM=0x80
> send: NID=0x23, VERB=0x368(set_amp_gain_mute,I:L#8), PARM=0x80
> send: NID=0x23, VERB=0x358(set_amp_gain_mute,I:R#8), PARM=0x80
> send: NID=0x23, VERB=0x369(set_amp_gain_mute,I:L#9), PARM=0x80
> send: NID=0x23, VERB=0x359(set_amp_gain_mute,I:R#9), PARM=0x80
> send: NID=0x23, VERB=0x36a(set_amp_gain_mute,I:L#10), PARM=0x80
> send: NID=0x23, VERB=0x35a(set_amp_gain_mute,I:R#10), PARM=0x80
> ...
> 
>> get 28
> 28 Input Source:0
> ITEM: 0:Mic, 1:Internal Mic, 2:Line, VAL: [Mic]
The problem still exists in 3.2.7-1.fc16.x86_64 kernel, is there any
chance for a fix?

Julian
