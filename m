From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: iec958 and 24-bit audio
Date: Mon, 1 Nov 2010 15:03:31 -0500
Message-ID: <AANLkTinHgiCuusw9HJn_X1CH4YvA98VPtojNXAu58Gm=@mail.gmail.com>
References: <AANLkTi=U5k+mYy-kSCn4699LwFF6J2gxYQKePSNayDth@mail.gmail.com>
	<alpine.LNX.2.00.1011012017270.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 093A8243D8
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 21:03:31 +0100 (CET)
Received: by vws20 with SMTP id 20so4643402vws.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 13:03:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1011012017270.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> [alsa-lib]$ aplay -Diec958 file24bits.wav
>> aplay: set_params:1059: Sample format non available
>> Available formats:
>> - S16_LE
>> - S32_LE
>>
>> Is there an built-in assumption that the iec958 device can only take
>> as input what the slave hardware device supports?
>
> Use 'plug:iec958' device if you want to do the format conversion (from
> 24-bit to 32-bit format).

That seems to work, but what I was asking is if there's a direct path
without conversion? With plug:iec958 there's a conversion to 32-bits
and then you drop the lsb.
Also PulseAudio seems to rely on iec958 and when it doesn't work it
tries with plug:iec958. What's the recommended way of using this
device? Should we always open plug:iec958?
Thanks
-Pierre
