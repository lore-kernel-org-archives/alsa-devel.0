From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: snd-usb driver
Date: Fri, 13 Dec 2013 06:28:32 +1100 (EST)
Message-ID: <65532.86.105.95.182.1386876512.squirrel@boosthardware.com>
References: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
 <52A938BC.1050804@gmail.com>
 <CAJUVNoqL6BYESnvQqs_SGZB3EKzGQ1QNLWuK2oKebZfgGCcTvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id F38022608ED
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 20:28:21 +0100 (CET)
In-Reply-To: <CAJUVNoqL6BYESnvQqs_SGZB3EKzGQ1QNLWuK2oKebZfgGCcTvQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Fri, December 13, 2013 3:24 am, Lucas Takejame wrote:
> The product is the pedal board actually (which has the same hardware as a
> computer, but with the necessary changes to work out in a gig, like a
> hardcase and audio dedicated OS), we designed the sound card. I was only
> wondering if there was anything that I could change considering that we
> have a fixed mother board ( Intel DN2800MT ) and sound card ( works with a
> TUSB3200A and AK5386 ADC, AK4382A DAC, if that helps hehe), i don't know
> how much the driver being generic interfere in the performance, that is my
> doubt.
>

A well built standards compliant USB audio device will be able to handle
64 frames/period with the generic driver.

Have you run any benchmarks?

What is the lowest period size you can use with jack without getting
dropouts?

There may be some additional steps to configure your system for low
latency. In that case it is probably more appropriate to discuss on JACK
mailing list or back on LAD :-)


> Thanks for the responses,
>
> Lucas
>
>
> 2013/12/12 Gabriel M. Beddingfield <gabrbedd@gmail.com>
>
>>
>> Hi Lucas,
>>
>> I wonder if I've misunderstood what you're trying to accomplish...
>>
>>
>> On 12/11/2013 08:59 AM, Lucas Takejame wrote:
>>
>>> snd-usb driver). I know the code is already optimized but I was hoping
>>> that, since we only use one specific sound card and we won't need a
>>> generic
>>> driver, I could change something in the code to optimize it latency
>>> wise.
>>> I
>>>
>>
>> Are you creating a product that *is* a USB sound card and you want to
>> write a driver for it?
>>
>> ...or do you have some pre-existing USB sound card (and driver) that
>> this
>> product is using and you're trying to set up a low-latency audio
>> workstation that uses it?
>>
>> -gabe
>>
>>
>
>
> --
> Lucas Conejero Takejame
> Engenharia El=E9trica - =EAnfase em computa=E7=E3o
> Escola Polit=E9cnica - USP
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


--
Patrick Shirkey
Boost Hardware Ltd
