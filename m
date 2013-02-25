From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] Allow to switch hardware sampe rate on EMU
Date: Mon, 25 Feb 2013 09:47:15 +0000
Message-ID: <CAD-m0i_fcQM2Cc3LaoZ0AKY4xsu2OHGoV2a+iqdJcJ+SX0chKg@mail.gmail.com>
References: <CAD-m0i9NwmVsGH53cphNM3ikDAanBU2bwE7Wa0KTASbwnW-aqA@mail.gmail.com>
 <s5h8v6cu5oo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C47B265150
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 10:47:16 +0100 (CET)
Received: by mail-qc0-f175.google.com with SMTP id j3so1216190qcs.6
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 01:47:15 -0800 (PST)
In-Reply-To: <s5h8v6cu5oo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013/2/25, Takashi Iwai <tiwai@suse.de>:
> At Fri, 22 Feb 2013 17:59:38 +0000,
> Mihail Zenkov wrote:
>>
>> Commit 57e5c63007955838043e34c732d224b2cbbb128f "emu10k1: allow to
>> disable the SRC"
>> force hardware use only one rate (48000 hz), but EMU have support two
>> hardware
>> sampling rates (44100 and 48000 hz).
>
> The commit serves for its purpose: it restricts the sample rate only
> when user specifies to disable h/w resample.  Emu chip is driven in
> 48k rate and other rates are the result of resampling.

Yes you right, but only for Audigy + Emu chip. EMU 0404/1010/1616 have
two crystal oscillators on board. User can switch hardware sample rate
(in alsa - with alsamixer). My patch check if we have real EMU and
choose correct sample rate to restrict.
