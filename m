From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Subject: Re: SoC Atmel SSC stereo problem
Date: Fri, 22 Oct 2010 23:39:01 +0200
Message-ID: <4CC20475.3020900@fh-kl.de>
References: <4CC1AB01.3020603@fh-kl.de> <4CC1B7CD.3030703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from post.fh-kl.de (post.fh-kl.de [143.93.17.200])
	by alsa0.perex.cz (Postfix) with ESMTP id EE2F1103863
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 23:39:04 +0200 (CEST)
In-Reply-To: <4CC1B7CD.3030703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> I have some trouble with stereo audio through the atmal ssc interface
>> based on at91-ssc.c.
> (Merged into atmel_ssc_dai.c since about one year ago.)
>> Unfortunately left and right channels were swapped periodically.
>>
>> In my environment the codec supplies the BLCK and LRC clocks and
>> the SSC is configured to transmit one sample on both edges of the LRC clock.
>> But I guess the audio frames will always start with a frame of the left channel
>> while the LRC clock is in an undefined state.
> Indeed.
>
>> How does normally the audio driver detect when a left and when a right channel
>> frame should be send and with which it should start ?
> The driver cannot do anything about this; the hardware must be told
> to start transmitting at the falling edge.
>
> If possible.
If there is only one channel to transfer, I set the start of 
transmission on the rising edge (left justified format). But if I do 
this for two channels, both channels will be transmit on the left 
channel, this is what I would expect. Is there way to tell the hardware 
(Atmel SSC on at91rm9200) that 2 Frames shall be send after a rising 
edge with an indication that the second frame shall be send after the 
falling edge ? This is the way it should work, but of course I don't 
know if it's even possible.
> Is there a reason why the codec supplies LRC?
>
The SSC is connected to a FPGA that assigns the bus to different devices 
depending on the application. And for all applications the FPGA 
generates the clocks. Maybe this is not the best solution but I will try 
to deal with this limitation first before I try to persuade other people 
to change it.
