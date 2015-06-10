From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Wed, 10 Jun 2015 12:59:53 +0800
Message-ID: <CAN8cciY3w+6NZOutzDJZHgHV2Q_LeZqD6zeEwy=tis7aff0tDQ@mail.gmail.com>
References: <5576B419.5010505@canonical.com>
 <CAN8cciZLkpzNYRcKDxExX7WpaQJ1QVNnEecnYLLN4MqK=orKcA@mail.gmail.com>
 <5576E81F.9070703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D1D38265876
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 06:59:54 +0200 (CEST)
Received: by oihd6 with SMTP id d6so25031466oih.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 21:59:53 -0700 (PDT)
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

>
>>
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

http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PFid=27&Level=5&Conn=4&ProdID=166

The ALC269 integrates five hardware equalizer bands composed of one
low-pass filter, one high-pass filter, and three band-pass filters to
compensate for mini-speaker frequency response

Do you mean alc255 does not have tbr hardware equalizer ?
