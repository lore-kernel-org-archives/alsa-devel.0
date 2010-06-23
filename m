From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 17:10:01 +0200
Message-ID: <4C2223C9.2080602@ladisch.de>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>	<4C21F88C.6000200@ladisch.de>
	<AANLkTik4XvRinUEUjqpqXdnxXFIcPGs9zcRk-_yf1xHW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 75B7F244A4
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 17:10:05 +0200 (CEST)
In-Reply-To: <AANLkTik4XvRinUEUjqpqXdnxXFIcPGs9zcRk-_yf1xHW@mail.gmail.com>
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

pl bossart wrote:
>>> If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
>>> device, I can use alsamixer/amixer to mute/unmute.
>>>
>>> Now if I use the iec958: plugin, I can't control the mute switch any longer:
>>
>> Muting an AC-3 stream would require encoding a stream of silent PCM
>> samples (no data is not the same as silence); therefore, the iec958
>> plugin disallows muting.
> 
> Actually the problem happens also with plain PCM rendered on the
> iec958 device.There's no way to use the IEC switch.
> So why do we have an S/PDIF switch in the first place?

Because the hardware has this switch; the driver just exposes all
hardware features.  

> If it cannot be used when you sent IEC-formatted data (be that PCM
> or AC3-formatted data), then why bother?

Some codecs allow looping back the ADC output to the SPDIF transmitter.
In these cases, disabling the SPDIF transmitter might be useful.


Regards,
Clemens
