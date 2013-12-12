From: Lucas Takejame <lucas@takejame.com.br>
Subject: Re: snd-usb driver
Date: Thu, 12 Dec 2013 14:24:45 -0200
Message-ID: <CAJUVNoqL6BYESnvQqs_SGZB3EKzGQ1QNLWuK2oKebZfgGCcTvQ@mail.gmail.com>
References: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
 <52A938BC.1050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CC84126087C
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 17:25:06 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id bz8so2745844wib.11
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 08:25:06 -0800 (PST)
In-Reply-To: <52A938BC.1050804@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The product is the pedal board actually (which has the same hardware as a
computer, but with the necessary changes to work out in a gig, like a
hardcase and audio dedicated OS), we designed the sound card. I was only
wondering if there was anything that I could change considering that we
have a fixed mother board ( Intel DN2800MT ) and sound card ( works with a
TUSB3200A and AK5386 ADC, AK4382A DAC, if that helps hehe), i don't know
how much the driver being generic interfere in the performance, that is my
doubt.

Thanks for the responses,

Lucas


2013/12/12 Gabriel M. Beddingfield <gabrbedd@gmail.com>

>
> Hi Lucas,
>
> I wonder if I've misunderstood what you're trying to accomplish...
>
>
> On 12/11/2013 08:59 AM, Lucas Takejame wrote:
>
>> snd-usb driver). I know the code is already optimized but I was hoping
>> that, since we only use one specific sound card and we won't need a
>> generic
>> driver, I could change something in the code to optimize it latency wise.
>> I
>>
>
> Are you creating a product that *is* a USB sound card and you want to
> write a driver for it?
>
> ...or do you have some pre-existing USB sound card (and driver) that this
> product is using and you're trying to set up a low-latency audio
> workstation that uses it?
>
> -gabe
>
>


-- =

Lucas Conejero Takejame
Engenharia El=E9trica - =EAnfase em computa=E7=E3o
Escola Polit=E9cnica - USP
