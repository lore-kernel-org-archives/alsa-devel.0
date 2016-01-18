From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Mon, 18 Jan 2016 23:11:20 +0800
Message-ID: <CAGnHSEnCzSm+NNqcW1krzOPW6ZCK3ACOGSAed2z8tavGMTuysg@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
 <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
 <CAN8ccibo3rEqvAEEqH6yqHwVAipJAFH576-VF-QpaRv=d8274g@mail.gmail.com>
 <CAGnHSEmG_9DLW6EQS2229Kq9hDF-u0J01gJXP6ozdr67Zrsb_g@mail.gmail.com>
 <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
 <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
 <CAN8ccibko9ZJSOiL5DgD_rhWx=oHi_+=+qPPW-AGc4u7TnyifQ@mail.gmail.com>
 <CAGnHSE==FT8S+A6V197Q93DaMGEm3fYZ9qbo0eKVKdHbJZhGLw@mail.gmail.com>
 <CAN8cciafE=3=Ex7OO9tykJ_NW+XjmziKJD0T=h1aJ5d1DM+rGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A2D261A28
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:11:22 +0100 (CET)
Received: by mail-yk0-f176.google.com with SMTP id a85so537874291ykb.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:11:22 -0800 (PST)
In-Reply-To: <CAN8cciafE=3=Ex7OO9tykJ_NW+XjmziKJD0T=h1aJ5d1DM+rGQ@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

different from what? each other? you mean the confs (yeah that's why I
pasted the links) or the actual cards (so that they derserve confs in
different from SOMEHOW)?

and emu10k1 doesn't even have "side".

I know some of the confs use multi and some use front. that's my
question/doubt, coz that seem to imply that some of their drivers are
sort of "incomplete".

and you haven't been really making any point/sense tbh. i don't feel
like i should continue any discussion/conversation with you. it's out
of the scope of my patch anyway.

On 18 January 2016 at 17:54, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
>>
>> Compare these these two conf:
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/CA0106.conf;h=2f0eaf0afdc8dc826cbd3722b61cdb3310ca07f0;hb=HEAD
>>
>> BOTH of them shows that the four "stereo" ports they have exist as
>> "device", but the SB-XFi.conf does not use the multi plugin to bind
>> them to provide a surround PCM like CA0106.conf; instead it can simply
>> use the "front" PCM, apparently.
>
> These two cards are different, emu10k1  have "rear" device,  "centerlfe" and
> "side" devices
>
> but they use multi plugin instead of surroundxx use pcm.front
>
> SB-XFi.pcm.surround40.0 cards.SB-XFi.pcm.front.0
> SB-XFi.pcm.surround51.0 cards.SB-XFi.pcm.front.0
> SB-XFi.pcm.surround71.0 cards.SB-XFi.pcm.front.0
