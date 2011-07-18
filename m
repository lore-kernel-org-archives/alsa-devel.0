From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Mon, 18 Jul 2011 13:18:03 +0200
Message-ID: <4E24166B.1000903@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org> <4E047441.4010003@gmail.com>
	<s5hpqm2v0zq.wl%tiwai@suse.de> <4E05C1B1.50302@gmail.com>
	<4E05C704.4080806@gmail.com> <4E05CE02.1070801@gmail.com>
	<s5hei2fvmgw.wl%tiwai@suse.de> <4E082166.5060902@gmail.com>
	<s5hpqlz3a3b.wl%tiwai@suse.de> <s5hhb7b315l.wl%tiwai@suse.de>
	<4E08E33D.3060608@gmail.com> <s5htybaton8.wl%tiwai@suse.de>
	<4E0B62B6.6000007@gmail.com> <4E0B6BE0.1010003@gmail.com>
	<4E0B7D22.3040009@gmail.com> <s5hei2bsxdv.wl%tiwai@suse.de>
	<4E0C17F2.5070704@gmail.com> <s5hzkkzreqr.wl%tiwai@suse.de>
	<4E0CABBC.3070801@gmail.com> <s5hwrg3i5eb.wl%tiwai@suse.de>
	<4E0CBBED.9050501@gmail.com> <s5hsjqri0eo.wl%tiwai@suse.de>
	<4E0CD984.9050408@gmail.com> <s5hpqluinj5.wl%tiwai@suse.de>
	<4E1243C3.5040302@gmail.com>
	<CAN8cciZX_Fzm5ZOR+aZ5BXpEw89Nmk6WqTs3VOTbo1jwQuRyuA@mail.gmail.com>
	<4E22CDC0.6090007@gmail.com> <4E22D2D2.4040208@gmail.com>
	<s5hei1o59dm.wl%tiwai@suse.de> <s5haacckm1k.wl%tiwai@suse.de>
	<4E2415C2.8020600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD842447F
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 13:18:18 +0200 (CEST)
Received: by fxh2 with SMTP id 2so6392642fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 04:18:17 -0700 (PDT)
In-Reply-To: <4E2415C2.8020600@gmail.com>
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

W dniu 18.07.2011 13:15, Julian Sikorski pisze:
> W dniu 18.07.2011 10:52, Takashi Iwai pisze:
>> And I can't reproduce your problem with the alsa-info.sh output above.
>> Give more exact information what you did and what is the problem.
>>
>>
>> thanks,
>>
>> Takashi
> I'm sorry for the confusion - let me sum up the current situation. With
> the fixes you pushed to sound-2.6/master I was able to get 5.1 sound out
> of my laptop. The only missing bit was the 7.1 sound. And the last
> channel goes via a jack/optical spdif hybrid. The problem is that the
> BIOS does not announce that and as such alsa is unaware of the side
> surround channel.
> Using Raymond's advice, I was able to make the sound come out of the
> last jack, by changing some values for pin 0x17 (described as sidesurr
> in the datasheet), diff is attached. I basically checked what was the
> difference in alsa-info.sh output when I was changing number of channels
> with alsamixer, and then did the same for pin 0x17.
> Since, from what I understood, you wanted me to figure out which pin is
> connected to the last jack [1], I thought this information would be
> useful to fix BIOS shortcomings.
> Other problem is that the volume on that jack is controlled by center
> and lfe sliders (in alsamixer), which is probably caused by the fact
> that alsa is unaware of the 7.1 sound.
> If more information is needed, please let me know what do you need in
> addition to alsa-info.sh output.
>
> Regards,
> Julian
>
> [1] http://article.gmane.org/gmane.linux.alsa.devel/86749
The diff is reverted for some reason - setting pin-ctls to 0x40: OUT and 
Amp-Out vals to [0x00 0x00] is what makes the sound appear. Sorry for 
the confusion.

Julian
