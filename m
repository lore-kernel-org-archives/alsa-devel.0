From: Dan MacDonald <allcoms@gmail.com>
Subject: Re: CM6206, S/PDIF + JACK
Date: Wed, 14 Nov 2012 10:29:04 +0000
Message-ID: <CANOoOjugufJhFwmJhaSUH-JN1Zpe+wRiBOvEe9eGjVtjLkH=cA@mail.gmail.com>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
 <50A2434A.8000803@ladisch.de>
 <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
 <50A2BACE.80107@ladisch.de>
 <CANOoOju1RjMdutspkvE23sErr7x-B-gbq5jVk4r3KS02vbx4Bg@mail.gmail.com>
 <50A34AFD.3070801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 375DD2652CF
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:29:05 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so225421vbb.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 02:29:04 -0800 (PST)
In-Reply-To: <50A34AFD.3070801@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens et al(sa)!

Yes, that was the problem and I have SPDIF capture working now!

I couldn't find any simpleton friendly docs for this process so I wrote a
short howto:

http://www.linuxmusicians.com/viewtopic.php?f=19&t=10271


Thanks for your help!


On Wed, Nov 14, 2012 at 7:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Dan MacDonald wrote:
> > numid=9,iface=MIXER,name='Line Capture Switch'
> >   : values=off
> > numid=7,iface=MIXER,name='Mic Capture Switch'
> >   : values=off
> > numid=11,iface=MIXER,name='IEC958 In Capture Switch'
> >   : values=on
>
> Okay.
>
> > numid=14,iface=MIXER,name='PCM Capture Source'
> >   ; Item #0 'Mic'
> >   ; Item #1 'Line'
> >   ; Item #2 'IEC958 In'
> >   ; Item #3 'Mixer'
> >   : values=0
>
> But this is still set to Mic, ...
>
> > numid=12,iface=MIXER,name='PCM Capture Switch'
> >   : values=off
>
> ... and capturing is disabled altogether.
> (Or is this one for capturing playback data?)
>
>
> Regards,
> Clemens
>
