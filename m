From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CM6206, S/PDIF + JACK
Date: Wed, 14 Nov 2012 08:40:45 +0100
Message-ID: <50A34AFD.3070801@ladisch.de>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
 <50A2434A.8000803@ladisch.de>
 <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
 <50A2BACE.80107@ladisch.de>
 <CANOoOju1RjMdutspkvE23sErr7x-B-gbq5jVk4r3KS02vbx4Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1A4D926031E
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 08:40:48 +0100 (CET)
In-Reply-To: <CANOoOju1RjMdutspkvE23sErr7x-B-gbq5jVk4r3KS02vbx4Bg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan MacDonald <allcoms@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dan MacDonald wrote:
> numid=9,iface=MIXER,name='Line Capture Switch'
>   : values=off
> numid=7,iface=MIXER,name='Mic Capture Switch'
>   : values=off
> numid=11,iface=MIXER,name='IEC958 In Capture Switch'
>   : values=on

Okay.

> numid=14,iface=MIXER,name='PCM Capture Source'
>   ; Item #0 'Mic'
>   ; Item #1 'Line'
>   ; Item #2 'IEC958 In'
>   ; Item #3 'Mixer'
>   : values=0

But this is still set to Mic, ...

> numid=12,iface=MIXER,name='PCM Capture Switch'
>   : values=off

... and capturing is disabled altogether.
(Or is this one for capturing playback data?)


Regards,
Clemens
