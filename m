From: loody <miloody@gmail.com>
Subject: Re: where to get snd_pcm_hardware info when usb audio
 device plug in?
Date: Thu, 29 Aug 2013 11:53:23 +0800
Message-ID: <CANudz+v219cxgAwo2RtAMvmvQ+18doPX0qsX4Pc+vk9TAe3D2g@mail.gmail.com>
References: <CANudz+uTk+GDAj=NfHQ_6ZrL6=ZmWJfXAnwRqk7yHPr4s0Jg1A@mail.gmail.com>
 <521E07A1.5020807@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CEBB52615FA
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 05:53:23 +0200 (CEST)
Received: by mail-wi0-f169.google.com with SMTP id l12so7551775wiv.4
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 20:53:23 -0700 (PDT)
In-Reply-To: <521E07A1.5020807@ladisch.de>
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

hi clements:

2013/8/28 Clemens Ladisch <clemens@ladisch.de>:
> loody wrote:
>> is it possible to get snd_pcm_hardware information in /proc, /sys or
>> anywhere when usb audio device plug in?
>>
>> if no, is there api I can take in usermode to get snd_pcm_hardware of
>> this usb audio device?
>
> Something like this?
> http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c
I download the file and
1. cross-compile it with alsa-lib-1.0.23

but I get below message
# ./hw_params
no soundcards found...no soundcards found...

but in my /proc/asound/cards, there seems a card exist.

# cat /proc/asound/cards
0 [default        ]: USB-Audio - Microsoft LifeChat LX-3000
                      Microsoft LifeChat LX-3000  at usb-1, full speed

Did I miss anything need to pay attention?

thanks for your kind help,


>
>
> Regards,
> Clemens



-- 
Regards,
