From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Mon, 18 Jan 2016 14:50:03 +0800
Message-ID: <CAN8ccibko9ZJSOiL5DgD_rhWx=oHi_+=+qPPW-AGc4u7TnyifQ@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
 <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
 <CAN8ccibo3rEqvAEEqH6yqHwVAipJAFH576-VF-QpaRv=d8274g@mail.gmail.com>
 <CAGnHSEmG_9DLW6EQS2229Kq9hDF-u0J01gJXP6ozdr67Zrsb_g@mail.gmail.com>
 <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
 <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B8E22260481
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:50:03 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id oh2so342151233lbb.3
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 22:50:03 -0800 (PST)
In-Reply-To: <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
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

> Then what about this:
>
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
> It seems to be allow the "multi-streaming" you mentioned but it
> doesn't need the multi plugin.
>
> Hmm, I feel like definitions for "ttable PCMs" in Echo_Echo3G.conf
> should be cleaned up...

No,  only those creative sound card emu10k1 and ca0106 allow up to four pcm
devices

For hda,  you need to change the logic of alsa playback stream similar to
multiple alsa capture devices,  you can use hint "indep_hp=1" to enable
multi stream playback (analog and alt analog playback )

Freebsd allow you to use your hda intel as four independent pcm devices

https://www.freebsd.org/cgi/man.cgi?query=snd_hda&sektion=4&manpath=FreeBSD+7.2-RELEASE
