From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Playback and capture synchronization
Date: Wed, 09 Nov 2011 10:38:05 -0800
Message-ID: <4EBAC88D.1040508@codeaurora.org>
References: <4EB9E331.8070401@codeaurora.org> <4EBA6A22.6090308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 471D2243F4
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 19:38:08 +0100 (CET)
In-Reply-To: <4EBA6A22.6090308@ladisch.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>
List-Id: alsa-devel@alsa-project.org

On 11/9/2011 3:55 AM, Clemens Ladisch wrote:
> Patrick Lai wrote:
>> I have a use case requiring playback and capture starting at the same
>> time. Latency between starting of playback and capture streams need to
>> be less than few PCM samples. Base on my understanding on ALSA which
>> does not have the concept of grouping multiple streams,
>
> snd_pcm_link()
Awesome! I will look into this API

> If the driver doesn't actually implement starting of linked streams
> (which would be pointless if the hardware doesn't support it), ALSA
> calls the second trigger callback after the first one.
>
> It might be possible to implement simultaneous starting of two streams.
> What hardware (driver) are you using?
It's Qualcomm hardware. As far as I know, HW has this synchronization 
support but I would have to build driver to make use of this functionality

Thanks very much for the feedback

>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
