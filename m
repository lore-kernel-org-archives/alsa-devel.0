From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Fri, 01 Jul 2011 21:35:00 +0200
Message-ID: <4E0E2164.20501@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>	<s5htybaton8.wl%tiwai@suse.de>	<4E0B62B6.6000007@gmail.com>	<4E0B6BE0.1010003@gmail.com>	<4E0B7D22.3040009@gmail.com>	<s5hei2bsxdv.wl%tiwai@suse.de>	<4E0C17F2.5070704@gmail.com>	<s5hzkkzreqr.wl%tiwai@suse.de>	<4E0CABBC.3070801@gmail.com>	<s5hwrg3i5eb.wl%tiwai@suse.de>	<4E0CBBED.9050501@gmail.com>	<s5hsjqri0eo.wl%tiwai@suse.de>	<4E0CD984.
 9050408@gmail.com>	<s5hpqluinj5.wl%tiwai@suse.de>	<s5h7h82ihgi.wl%tiwai@suse.de>	<4E0E1893.80206@gmail.com>
	<s5htyb5hkgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 23B1C1039F0
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 21:35:06 +0200 (CEST)
Received: by wwj26 with SMTP id 26so2698720wwj.20
	for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2011 12:35:05 -0700 (PDT)
In-Reply-To: <s5htyb5hkgf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W dniu 01.07.2011 21:25, Takashi Iwai pisze:
> At Fri, 01 Jul 2011 20:57:23 +0200,
> Julian Sikorski wrote:
>>
>> W dniu 01.07.2011 09:32, Takashi Iwai pisze:
>>> At Fri, 01 Jul 2011 07:21:34 +0200,
>>> Takashi Iwai wrote:
>>>>
>>>> At Thu, 30 Jun 2011 22:16:04 +0200,
>>>> Julian Sikorski wrote:
>>>>>
>>>>> It works, thanks! In more detail, the Speaker/Headphone situation is
>>>>> back to 2.6.38 state - you can regulate them independently, but muting
>>>>> one mutes the other. LFE/Center and Surround keep working correctly too.
>>>>> The new output of alsa-info.sh:
>>>>> http://www.alsa-project.org/db/?f=45bc0df9747371b348bde6c4aa508b2ba44aff47
>>>>
>>>> Right, it's because ALC892 has no mute-control in pin widgets but
>>>> only in the mixer widget.  And HP and speaker paths share the same
>>>> mixer, thus it's impossible to mute independently.
>>>
>>> I seem to have lied.  It should be possible, and the emulator shows it
>>> must be working well.
>>>
>>> Do I understand correctly that the problem is that both HP and speaker
>>> outputs are muted simultaneously when you either of "Headphone" or
>>> "Speaker" mixer switch is muted?
>>>
>>> If so, please give alsa-info.sh outputs at the problematic state, i.e.
>>> the speaker gets muted by the headphone mixer switch or vice versa,
>>> just to confirm.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>> Here you go:
>> http://www.alsa-project.org/db/?f=c8f1e149c155ed950aea1a7327a5800fc2b61da2
>> I muted the speakers and the headphones went silent.
> 
> Hm, I see no obvious problem in the codec tree and alsa mixers.
> Could you check whether the playback without PulseAudio has the same
> issue?  Try pasuspender, e.g.
> 
> 	% pasuspender aplay -Dplughw foo.wav
> 
> (Depending on the version of PA, you might need to put '--' between
>  pasuspender and aplay.)
> 
> 
> Takashi
You are right, with pulseaudio out of the way everything works fine.
Anything particular I should tell them?

Julian
