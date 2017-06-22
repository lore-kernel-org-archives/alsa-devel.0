From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib: Dmix slowptr latency behaviour
Date: Thu, 22 Jun 2017 09:18:58 +0200
Message-ID: <a65d12c4-84d0-1f8f-4d76-493da7404df6@ladisch.de>
References: <CAPdSWWRCeXakghaDxSXms9ui5uV3RNHGeiiPpvO1B8gfDBGrew@mail.gmail.com>
 <CAPdSWWQieVJ5gtr64BCTdCK0XYYTqCLZ68PXWY6sT7V+nEePJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 765B9266D18
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 09:19:00 +0200 (CEST)
In-Reply-To: <CAPdSWWQieVJ5gtr64BCTdCK0XYYTqCLZ68PXWY6sT7V+nEePJA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matin Momin <matinmomin@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matin Momin wrote:
>> Matin Momin wrote:
>>>> arecord -D"dsp" -r48000  -c2 -fs32_le | aplay -D"dmix1"
>
>> To reduce the latency, reduce arecord's period size and/or aplay's
>> buffer size.
>
>  Actually, my aim is to understand if setting dmix slowptr to true
> leads to increase in playback latency by buffer_time. Is it a known
> issue or could it be because of the specific alsa device?

As far as I know, slowptr should not increase the latency (in fact, it
might decrease it).

But it's hard to say anything without knowing the actual period and
buffer sizes of the devices.


Regards,
Clemens
