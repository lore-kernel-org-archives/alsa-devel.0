From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Mon, 18 Jan 2016 17:54:41 +0800
Message-ID: <CAN8cciafE=3=Ex7OO9tykJ_NW+XjmziKJD0T=h1aJ5d1DM+rGQ@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
 <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
 <CAN8ccibo3rEqvAEEqH6yqHwVAipJAFH576-VF-QpaRv=d8274g@mail.gmail.com>
 <CAGnHSEmG_9DLW6EQS2229Kq9hDF-u0J01gJXP6ozdr67Zrsb_g@mail.gmail.com>
 <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
 <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
 <CAN8ccibko9ZJSOiL5DgD_rhWx=oHi_+=+qPPW-AGc4u7TnyifQ@mail.gmail.com>
 <CAGnHSE==FT8S+A6V197Q93DaMGEm3fYZ9qbo0eKVKdHbJZhGLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A048C260506
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 10:54:42 +0100 (CET)
Received: by mail-lf0-f43.google.com with SMTP id h129so121379928lfh.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 01:54:42 -0800 (PST)
In-Reply-To: <CAGnHSE==FT8S+A6V197Q93DaMGEm3fYZ9qbo0eKVKdHbJZhGLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Compare these these two conf:
>
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
>
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/CA0106.conf;h=2f0eaf0afdc8dc826cbd3722b61cdb3310ca07f0;hb=HEAD
>
> BOTH of them shows that the four "stereo" ports they have exist as
> "device", but the SB-XFi.conf does not use the multi plugin to bind
> them to provide a surround PCM like CA0106.conf; instead it can simply
> use the "front" PCM, apparently.

These two cards are different, emu10k1  have "rear" device,  "centerlfe"
and "side" devices

but they use multi plugin instead of surroundxx use pcm.front

SB-XFi.pcm.surround40.0 cards.SB-XFi.pcm.front.0
SB-XFi.pcm.surround51.0 cards.SB-XFi.pcm.front.0
SB-XFi.pcm.surround71.0 cards.SB-XFi.pcm.front.0
