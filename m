From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Wed, 21 Mar 2012 10:16:43 +0000
Message-ID: <4F69AA8B.3080409@citrix.com>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CE292439A
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 11:07:21 +0100 (CET)
In-Reply-To: <4F6881B6.2020903@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for taking the time to answer about this detail.

On 20/03/12 13:10, Clemens Ladisch wrote:
> Stefano Panella wrote:
>> I have been reading the documentation on "Writing an ALSA Driver" and I
>> am still not completely clear on the meaning of the "pointer" callback
>> in the pcm operations.
>>
>> 1) In case of a playback stream, is the pointer referring to wich sample
>> is currently playing on the DAC or to which is it the last frame read by
>> the HW from the alsa memory buffer?
>
> It's the position of the first frame not yet read from the memory buffer.
>
> The delay between the DMA and the DAC output would be reported by
> adjusting runtime->delay, but drivers usually do not bother to do this,
> except when this delay becomes rather large because of additional
> queueing, e.g., in the USB driver.
>
ok, I was wondering about applications like skype, trying to do some 
background noise cancellation, or to eliminate echo when using speakers.
I was thinking in this case the delay should be accurate for Playback 
and Capture as well, or am I wrong?
>> 4) is there any test I could run to check I have implemented correctly
>> the "pointer" callback? Or any application which would need very high
>> "pointer" precision like frame precision?
>
> PulseAudio.
> Or run mplayer and look at the A-V value in the status line.
>
I will try these as well.
>
> Regards,
> Clemens

In case this pv XEN alsa driver will start to work properly, where 
should I post the patches? Who is currently the linux kernel alsa driver 
mantainer?

Thanks again,

Stefano.
