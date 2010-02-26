From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 26 Feb 2010 08:45:40 +0800
Message-ID: <4f3252891002251645m4807648aq7eec510584486ea8@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 422B61039CC
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:45:42 +0100 (CET)
Received: by pxi1 with SMTP id 1so302709pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 16:45:41 -0800 (PST)
In-Reply-To: <20100216210703.GA18109@tango.0pointer.de>
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

2010/2/17 Lennart Poettering <mznyfn@0pointer.de>

>
>
>
>
> Hmm, so you basically tuned the USB card's DAC/ADC level to the HDA
> card's DAC/ADC.
>
> I now measured the "Master" slider of my aureon (USB 0ccd:0028,
> TerraTec Aureon 5.1 MkII) with the aforementioned dbmeasure tool and a
> loopback cable. The aureon has 65536 volume steps, but
> I was too lazy to measure them all. So I only measured every
> 3000th. From the max volume to the min volume:
>
> 65536 0 dB
> 62536 0.00560039 dB
> 59536 0.00694678 dB
> 56536 0.00616732 dB
> 53536 0.00645077 dB
> 50536 0.00673421 dB
> 47536 -1.49514 dB
> 44536 -1.49455 dB
> 41536 -1.49648 dB
> 38536 -2.98666 dB
> 35536 -2.98486 dB
> 32536 -2.98536 dB
> 29536 -4.48688 dB
> 26536 -6.00084 dB
> 23536 -5.99928 dB
> 20536 -9.00246 dB
> 17536 -10.5425 dB
> 14536 -16.5274 dB
> 11536 -32.9435 dB
> 8536 -43.4326 dB
> 5536 -43.5066 dB
> 2536 -43.2968 dB
> 0 -43.4431 dB
>
> If you plot this it looks as if the card actually only implements 10
> or so discrete steps, and at around 10000 just becomes a constant
> function.
>
> ALSA reports -47.87 .. -1.97 for this. So it seems the overall range
> the USB data reports is not really that far off, but the volume
> function in bteween is.
>
> The noise level of these measurements is < -58 dB.
>
> What's the next step with this measurement data? Will you take it from
> here, or shall I provide you with more data?
>
> Lennart
>

How about dbmeasure the pulse device since the volume control seem also have
65536 step ?

Can you provide the result for the pulse device ?
