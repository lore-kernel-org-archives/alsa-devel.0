From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 09:34:38 +0800
Message-ID: <CAN8ccib8K2c_DpDEY3rpE_VS+YY9pRqH-h9usfa0K0-k4yxHLA@mail.gmail.com>
References: <5576B419.5010505@canonical.com>
 <CAN8cciZLkpzNYRcKDxExX7WpaQJ1QVNnEecnYLLN4MqK=orKcA@mail.gmail.com>
 <5576E81F.9070703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA1F26663E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 03:34:39 +0200 (CEST)
Received: by oihb142 with SMTP id b142so13178981oih.3
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:34:38 -0700 (PDT)
In-Reply-To: <5576E81F.9070703@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>> The alsa-info.txt for that Dell machine is at
>>
>> http://pastebin.ubuntu.com/11667982/
>>
>> The subwoofer is also at mono pin complex, are  there any low pass filter
>> for the subwoofer or vendor coeff need to be set ?
>
> I don't know it, I guess there is no hardware filter, it will work with
the software low pass filter in the pulseaudio.
>>

The funcional block diagram indicate equaliser is only connected to port D
This mean only the internal speaker can use high pass filter

Do you mean your can hear high frequency from the subwoofer of alc255 ?
