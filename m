From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Fri, 01 Jul 2011 13:18:00 +0200
Message-ID: <4E0DACE8.1000409@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org> <4E036C8F.3080709@gmail.com>
	<s5hvcvvzkzq.wl%tiwai@suse.de> <s5hk4cbzj6s.wl%tiwai@suse.de>
	<4E047441.4010003@gmail.com> <s5hpqm2v0zq.wl%tiwai@suse.de>
	<4E05C1B1.50302@gmail.com> <4E05C704.4080806@gmail.com>
	<4E05CE02.1070801@gmail.com> <s5hei2fvmgw.wl%tiwai@suse.de>
	<4E082166.5060902@gmail.com> <s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de> <4E08E33D.3060608@gmail.com>
	<s5htybaton8.wl%tiwai@suse.de> <4E0B62B6.6000007@gmail.com>
	<4E0B6BE0.1010003@gmail.com> <4E0B7D22.3040009@gmail.com>
	<s5hei2bsxdv.wl%tiwai@suse.de> <4E0C17F2.5070704@gmail.com>
	<s5hzkkzreqr.wl%tiwai@suse.de> <4E0CABBC.3070801@gmail.com>
	<s5hwrg3i5eb.wl%tiwai@suse.de> <4E0CBBED.9050501@gmail.com>
	<s5hsjqri0eo.wl%tiwai@suse.de> <4E0CD984.9050408@gmail.com>
	<s5hpqluinj5.wl%tiwai@suse.de> <4E0D65C2.7070106@gmail.com>
	<s5hmxgyikmi.wl%tiwai@suse.de> <4E0D68EB.5020909@gmail.com>
	<4E0D7243.7030202@gmail.com> <s5hboxeiiad.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 2507A103800
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 13:18:07 +0200 (CEST)
Received: by fxh2 with SMTP id 2so3491150fxh.9
	for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2011 04:18:04 -0700 (PDT)
In-Reply-To: <s5hboxeiiad.wl%tiwai@suse.de>
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

On 01/07/2011 09:14, Takashi Iwai wrote:
> At Fri, 01 Jul 2011 09:07:47 +0200,
> Julian Sikorski wrote:
>>
>>>>>>> So it seems that the only things remaining are the SPDIF/rear channel
>>>>>>> jack and the coupled muting issue.
>>>>>>
>>>>>> It's a BIOS bug.  It doesn't tell SPDIF is available.
>>>>>> Ditto for the 4th stereo out.  No pin is exposed by BIOS.
>>>>>
>>>>> I see. I can try updating the BIOS and see if it changes anything. If it
>>>>> doesn't, is there a way to work the problem around in the driver?
>>>>
>>>> You need to figure out pins manually by yourself, then change the
>>>> driver code.  I leave it as a homework :)
>>>
>>> :) I cannot write code, so I would not count on myself doing that. I
>>> will have a look into updating the BIOS though.
>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>
>>> Once again thanks for all the work you have done,
>>>
>>> Julian
>> Hmm, I googled a bit and it seems the way to find the pins is to write
>> values to user_pin_configs. So no coding knowledge seems needed, could
>> you give me some pointers on where to start?
>
> First off, read the HD-audio specification to understand what the values
> represent.  Then, use hda-analyzer or manually via hda-verb, figure out
> which widget corresponds to which I/O jack.  Compose the corresponding
> pin-config value, and put it to the sysfs file.  A brief description
> is found in Documentation/sound/alsa/HD-Audio.txt.
>
>
> Takashi
I was reading a bit more and it is all very confusing, but luckily I 
have holidays coming to try and figure it out. In the meantime, should I 
also try to find the pin for the internal subwoofer?
WRT the alsa-info.sh output I'll send it once I get home later today.

Julian
