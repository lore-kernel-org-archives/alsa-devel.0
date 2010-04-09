From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 9 Apr 2010 09:35:45 +0800
Message-ID: <x2w4f3252891004081835l7bb62923x6c9efbee5d66715a@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D3BC310398A
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 03:35:46 +0200 (CEST)
Received: by pvg12 with SMTP id 12so1633633pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 18:35:45 -0700 (PDT)
In-Reply-To: <z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/8 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> I'm sorry but I found out that I gave you wrong values of "amixer -D
> pulse": I just discovered that when I lower the alsa master volume, in
> some occasions the PCM volume goes to 99%, so now I will put it to
> 100% and check the pulse volume again.
>
> 0 dB    =  65536 [100%]
> -3 dB   =  57520 [88%]
> -6 dB   =  52057 [79%]
> -12 dB =  41034 [63%]
> -24 dB =  26090 [40%]
> -48 dB = 10151 [15%]
>
> So again, the only problem is that -48 dB IS mute, but it's not
> declared as mute.
> This is the real issue.
>

For AC97 codec , both Master and PCM are hardware volume controls

Register 02 - control the stereo master volume
Register 18 - PCM out volume

But on HDA , PCM is most likely a software volume control just like
pulseaudio volume control
