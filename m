From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Sun, 03 Jul 2011 13:22:12 +0200
Message-ID: <4E1050E4.9030809@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>
	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>
	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>
	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>
	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>
	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>
	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>
	<s5htybaton8.wl%tiwai@suse.de>	<4E0B62B6.6000007@gmail.com>
	<4E0B6BE0.1010003@gmail.com>	<4E0B7D22.3040009@gmail.com>
	<s5hei2bsxdv.wl%tiwai@suse.de>	<4E0C17F2.5070704@gmail.com>
	<s5hzkkzreqr.wl%tiwai@suse.de>	<4E0CABBC.3070801@gmail.com>
	<s5hwrg3i5eb.wl%tiwai@suse.de>	<4E0CBBED.9050501@gmail.com>
	<s5hsjqri0eo.wl%tiwai@suse.de>	<4E0CD984.9050408@gmail.com>
	<s5hpqluinj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 04723248D6
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jul 2011 13:22:17 +0200 (CEST)
Received: by fxh2 with SMTP id 2so4839664fxh.9
	for <alsa-devel@alsa-project.org>; Sun, 03 Jul 2011 04:22:17 -0700 (PDT)
In-Reply-To: <s5hpqluinj5.wl%tiwai@suse.de>
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

W dniu 01.07.2011 07:21, Takashi Iwai pisze:
> At Thu, 30 Jun 2011 22:16:04 +0200,
> Julian Sikorski wrote:
>>
>> W dniu 30.06.2011 21:28, Takashi Iwai pisze:
>>> At Thu, 30 Jun 2011 20:09:49 +0200,
>>> Julian Sikorski wrote:
>>>>
>>>> $ dmesg | grep XXX
>>>> [   14.813013] XXX alc662_auto_fill_dac_nids called
>>>> [   14.813015] XXX line_outs=1, 14/0/0
>>>> [   14.813016] XXX hp_outs=1, 1b/0/0
>>>> [   14.813018] XXX spk_outs=0, 0/0/0
>>>> [   14.813186] XXX filled dacs: 2/0/0/0/0, hp 0, ext 0/0/0
>>>> [   14.813187] XXX swap primary out to HP
>>>> [   14.813188] XXX spk=14
>>>> [   14.813190] XXX line=1b
>>>> [   14.813191] XXX alc662_auto_fill_dac_nids called
>>>> [   14.813192] XXX line_outs=1, 1b/0/0
>>>> [   14.813194] XXX hp_outs=0, 0/0/0
>>>> [   14.813195] XXX spk_outs=1, 14/0/0
>>>> [   14.813311] XXX filled dacs: 2/0/0/0/0, hp 0, ext 0/0/0
>>>> [   14.813560] XXX added multi-io pin 1a, dac 3
>>>> [   14.813814] XXX added multi-io pin 18, dac 4
>>>> [   14.813818] XXX create mixer ch 0 pin 1b dac 2 mix c
>>>> [   14.813821] XXX create mixer ch 1 pin 1a dac 3 mix d
>>>> [   14.813825] XXX create mixer ch 2 pin 18 dac 4 mix e
>>>
>>> How about the fix below?
>>>
>>>
>>> Takashi
>>
>> It works, thanks! In more detail, the Speaker/Headphone situation is
>> back to 2.6.38 state - you can regulate them independently, but muting
>> one mutes the other. LFE/Center and Surround keep working correctly too.
>> The new output of alsa-info.sh:
>> http://www.alsa-project.org/db/?f=45bc0df9747371b348bde6c4aa508b2ba44aff47
> 
> Right, it's because ALC892 has no mute-control in pin widgets but
> only in the mixer widget.  And HP and speaker paths share the same
> mixer, thus it's impossible to mute independently.
> 
>> So it seems that the only things remaining are the SPDIF/rear channel
>> jack and the coupled muting issue.
> 
> It's a BIOS bug.  It doesn't tell SPDIF is available.
> Ditto for the 4th stereo out.  No pin is exposed by BIOS.
> 
> 
> thanks,
> 
> Takashi

FYI I updated the BIOS to the latest available version, but it does not
seem to have changed anything. New alsa-info.sh output:
http://www.alsa-project.org/db/?f=89e03c194e599829e132517342cce70133f3fc7a

Julian
