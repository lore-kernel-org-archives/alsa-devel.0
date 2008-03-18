From: "van der Linden" <ejvanderlinden@hetnet.nl>
Subject: Re: arecord | aplay expected delay
Date: Tue, 18 Mar 2008 19:08:26 +0100
Message-ID: <000a01c88923$11059ba0$0202a8c0@uw4b58d8528225>
References: <00d301c8874d$51773ea0$0202a8c0@uw4b58d8528225>
	<47DD92D4.3010102@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hpsmtp-eml18.kpnxchange.com (hpsmtp-eml18.kpnxchange.com
	[213.75.38.118]) by alsa0.perex.cz (Postfix) with ESMTP id 12AED243E2
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 19:08:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The purpose is to connect a headset and to provide side-tone from the 
microphone to the headset.

The idea is to first create a short "software" loop and then to add filter 
algorithms.
With these algorithms I like to experiment.

However the side-tone delay must be short. Before I start making real audio 
filter algorithms, I want to know the bear minimum delay.

What can be expected using the Linux OS?

----- Original Message ----- 
From: "Rene Herman" <rene.herman@keyaccess.nl>
To: "van der Linden" <ejvanderlinden@hetnet.nl>
Cc: <alsa-devel@alsa-project.org>
Sent: Sunday, March 16, 2008 10:36 PM
Subject: Re: [alsa-devel] arecord | aplay expected delay


> On 16-03-08 11:05, van der Linden wrote:
>
>> I'm running arecord and aplay under uCLinux on a Blackfin DSP.
>>
>> In this way I loopback my audio.
>>
>> Does anyone know what delay I can expect between audio input and audio 
>> output?
>
> Not me, but you just want to loop without doing anything to it? An 
> analogue input? Every card I know can just loop it's own inputs out again. 
> That is, In -> Out, while you have In -> ADC -> bus -> cpu/memory -> 
> bus -> DAC -> Out.
>
>> I measure at my test board 50ms. I want to have about 1ms!
>
> You'd need a pretty fast system I suppose. Why does your card not loop 
> directly itself? You can still record it as well...
>
> Rene 
