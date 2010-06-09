From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Mixer volume/decibel mapping
Date: Wed, 09 Jun 2010 12:26:01 +0200
Message-ID: <4C0F6C39.1080009@gmx.de>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>	<201005211018.41802.vand2@gmx.de>	<AANLkTikylA_oo6GBKuLHewVX9oMCNjQMeS90HThDR47K@mail.gmail.com>	<4C0CB996.5010202@gmx.de>	<AANLkTinTV_MnU-rBOrLc66YhGFbP9SJVZ2p5DFlcS16T@mail.gmail.com>	<4C0DDCF2.90308@web.de>
	<AANLkTilEz8pdtx0yHSLAu7e1m4zHEV9mzGv-4_abzdKz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D333B103927
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 12:25:44 +0200 (CEST)
In-Reply-To: <AANLkTilEz8pdtx0yHSLAu7e1m4zHEV9mzGv-4_abzdKz@mail.gmail.com>
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

Am 08.06.2010 17:31, schrieb Raymond Yau:
> 2010/6/8 Sebastian Holtermann <sebholt@web.de>
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Am 08.06.2010 03:03, schrieb Raymond Yau:
>>
>>>
>>>
>>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4883
>>>
>>> Pekka Lampila reported that when he set -40dB and only get back -9999999
>> by
>>> his program alsa_mixer_test.c
>>>
>>> I don't have emu10k1 so don't know whether this is a bug of alsa-lib or
>> not
>>
>> I also get a big jump from -39.60dB to -99999.99 dB for some emu10k1
>> sliders when I move them to the minimum although their advertised
>> minimum is -40dB. This looks like a way to express log ( 0 ).
>>
>>
> it seem that only "Wave Master" has mute switch , the other "Wave Rear" ,
> "Wave Center/Lfe" and "Wave side" only have volume control
> 
> Have you try the patch : emu10k1: allow high-resolution mixer controls
> 
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=4daf7a0c0b3dd3c2e2ec829ecee8608d04d67773

alsa-compile.sh did not work out of the box because of
"Cannot install kernel sources for unsupported distribution Debian"
and I don't have the time to dig deeper into kernel module compiling
right now.
