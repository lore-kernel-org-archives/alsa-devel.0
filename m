From: Hui Wang <hui.wang@canonical.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 11:32:04 +0800
Message-ID: <557A52B4.3080505@canonical.com>
References: <5576B419.5010505@canonical.com>
 <CAN8cciZLkpzNYRcKDxExX7WpaQJ1QVNnEecnYLLN4MqK=orKcA@mail.gmail.com>
 <5576E81F.9070703@canonical.com>
 <CAN8ccib8K2c_DpDEY3rpE_VS+YY9pRqH-h9usfa0K0-k4yxHLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 80DBF266638
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 05:32:12 +0200 (CEST)
In-Reply-To: <CAN8ccib8K2c_DpDEY3rpE_VS+YY9pRqH-h9usfa0K0-k4yxHLA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/12/2015 09:34 AM, Raymond Yau wrote:
>>>> The alsa-info.txt for that Dell machine is at
>>> http://pastebin.ubuntu.com/11667982/
>>>
>>> The subwoofer is also at mono pin complex, are  there any low pass filter
>>> for the subwoofer or vendor coeff need to be set ?
>> I don't know it, I guess there is no hardware filter, it will work with
> the software low pass filter in the pulseaudio.
> The funcional block diagram indicate equaliser is only connected to port D
> This mean only the internal speaker can use high pass filter
>
> Do you mean your can hear high frequency from the subwoofer of alc255 ?
I am not sure about it, but enable/disable the SW lfe filter will make 
the sound of subwoofer different
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
