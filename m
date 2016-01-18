From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Mon, 18 Jan 2016 16:30:57 +0800
Message-ID: <CAGnHSE==FT8S+A6V197Q93DaMGEm3fYZ9qbo0eKVKdHbJZhGLw@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
 <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
 <CAN8ccibo3rEqvAEEqH6yqHwVAipJAFH576-VF-QpaRv=d8274g@mail.gmail.com>
 <CAGnHSEmG_9DLW6EQS2229Kq9hDF-u0J01gJXP6ozdr67Zrsb_g@mail.gmail.com>
 <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
 <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
 <CAN8ccibko9ZJSOiL5DgD_rhWx=oHi_+=+qPPW-AGc4u7TnyifQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f181.google.com (mail-yk0-f181.google.com
 [209.85.160.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 776D3260506
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 09:30:58 +0100 (CET)
Received: by mail-yk0-f181.google.com with SMTP id a85so527657275ykb.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 00:30:58 -0800 (PST)
In-Reply-To: <CAN8ccibko9ZJSOiL5DgD_rhWx=oHi_+=+qPPW-AGc4u7TnyifQ@mail.gmail.com>
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

When did I say "hda"? Have you even read the link? I've been talking about X-Fi.

Compare these these two conf:
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/CA0106.conf;h=2f0eaf0afdc8dc826cbd3722b61cdb3310ca07f0;hb=HEAD

BOTH of them shows that the four "stereo" ports they have exist as
"device", but the SB-XFi.conf does not use the multi plugin to bind
them to provide a surround PCM like CA0106.conf; instead it can simply
use the "front" PCM, apparently.

On 18 January 2016 at 14:50, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
>> Then what about this:
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
>> It seems to be allow the "multi-streaming" you mentioned but it
>> doesn't need the multi plugin.
>>
>> Hmm, I feel like definitions for "ttable PCMs" in Echo_Echo3G.conf
>> should be cleaned up...
>
> No,  only those creative sound card emu10k1 and ca0106 allow up to four pcm
> devices
>
> For hda,  you need to change the logic of alsa playback stream similar to
> multiple alsa capture devices,  you can use hint "indep_hp=1" to enable
> multi stream playback (analog and alt analog playback )
>
> Freebsd allow you to use your hda intel as four independent pcm devices
>
> https://www.freebsd.org/cgi/man.cgi?query=snd_hda&sektion=4&manpath=FreeBSD+7.2-RELEASE
>
