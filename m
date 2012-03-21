From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: paravirtualized alsa  kernel driver for XEN
Date: Wed, 21 Mar 2012 10:11:07 +0000
Message-ID: <4F69A93B.4020707@citrix.com>
References: <4F6769A9.6090200@citrix.com> <4F68534A.70203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 21E6924520
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 11:01:47 +0100 (CET)
In-Reply-To: <4F68534A.70203@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks very much for your quick, detailed and useful response.

On 20/03/12 09:52, David Henningsson wrote:
> On 03/19/2012 06:15 PM, Stefano Panella wrote:
>> Hi,
>>
>> I am Stefano Panella, I am new to the list and I would like to take the
>> opportunity to ask some questions since I am trying to write a
>> paravirtualized alsa driver for XEN.
>>
>> If all goes well I would also like to upstream it on linux.
>>
>> I have been reading the documentation on "Writing an ALSA Driver" and I
>> am still not completely clear on the meaning of the "pointer" callback
>> in the pcm operations.
>>
>> The description say:
>>
>> "This callback is called when the PCM middle layer inquires the current
>> hardware position on the buffer."
>>
>> My question are:
>>
>> 1) In case of a playback stream, is the pointer referring to wich sample
>> is currently playing on the DAC or to which is it the last frame read by
>> the HW from the alsa memory buffer?
>>
>> 2) What does the pointer mean in case of a capture stream? Is it the
>> position of the current frame on the ADC or is the latest frame written
>> into the alsa buffer?
>
> I'd say that for both, it is being used by applications to know what
> memory they can read from or write to. But other people here might know
> better.
>
>> 3) in case it is the frame on the DAC/ADC, what happens if the callback
>> does not return the real DAC/ADC frame position but an approximate
>> value, let say rounded to 64 frames only?
>
> For the JACK sound server, I think it only needs to be as accurate as
> the period (i e if you have 4 periods with 64 samples each, you need to
> be able to return 0, 64, 128 and 192).
>
> For PulseAudio it's worse. The worse granularity, the more difficult for
> PulseAudio to have low-latency operation. PulseAudio also
> rewinds/rewrites the buffer occasionally and uses the pointer to know
> from when it should start rewriting.
>
>> 4) is there any test I could run to check I have implemented correctly
>> the "pointer" callback? Or any application which would need very high
>> "pointer" precision like frame precision?
>
> PulseAudio has an alsa-time-test application that relies heavily on the
> pointer callback being accurate. It's only for playback and I've never
> used it myself so I'm not completely sure about how to interpret the
> numbers.
I will try this for sure.
>
> In general, I believe PulseAudio (especially with timer-scheduling mode
> enabled) stress tests the driver quite hard and as such it is sometimes
> being used as a measure to see if the audio driver is successful. :-)
>
> Hopefully this provides some initial insights.
Yes
>

I will let you know how this work is progressing

Thanks again,

Stefano
