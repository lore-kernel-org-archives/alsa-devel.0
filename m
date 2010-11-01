From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: iec958 and 24-bit audio
Date: Mon, 1 Nov 2010 21:24:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011012117450.29422@eeebox2.perex-int.cz>
References: <AANLkTi=U5k+mYy-kSCn4699LwFF6J2gxYQKePSNayDth@mail.gmail.com>
	<alpine.LNX.2.00.1011012017270.29422@eeebox2.perex-int.cz>
	<AANLkTinHgiCuusw9HJn_X1CH4YvA98VPtojNXAu58Gm=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 791F4243EC
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 21:24:43 +0100 (CET)
In-Reply-To: <AANLkTinHgiCuusw9HJn_X1CH4YvA98VPtojNXAu58Gm=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Nov 2010, pl bossart wrote:

>>> [alsa-lib]$ aplay -Diec958 file24bits.wav
>>> aplay: set_params:1059: Sample format non available
>>> Available formats:
>>> - S16_LE
>>> - S32_LE
>>>
>>> Is there an built-in assumption that the iec958 device can only take
>>> as input what the slave hardware device supports?
>>
>> Use 'plug:iec958' device if you want to do the format conversion (from
>> 24-bit to 32-bit format).
>
> That seems to work, but what I was asking is if there's a direct path
> without conversion? With plug:iec958 there's a conversion to 32-bits
> and then you drop the lsb.

Almost all sound bridge chips works with 16-bit or 32-bit samples because 
it's more compatible with analog converters and the handling is more 
simple than for 3-byte formats. The conversion from the 32-bit format to 
the 32-bit S/PDIF frame is done inside hw (dropping the LSB, add S/PDIF 
frame status bits). Some hardware also supports raw S/PDIF frames 
directly.

> Also PulseAudio seems to rely on iec958 and when it doesn't work it
> tries with plug:iec958. What's the recommended way of using this
> device? Should we always open plug:iec958?

You can detect which formats are supported (like aplay does) and use the 
appropriate format to avoid using the plug layer in alsa-lib.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
