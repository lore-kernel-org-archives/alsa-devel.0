From: "Ki'Sak" <kisak42@gmail.com>
Subject: Re: CA0110 analog mic capture flatline
Date: Thu, 11 Jul 2013 08:12:03 -0400
Message-ID: <CAL=yMgUNZwRyoUsRk87sXP1zKx33asTjBstsbFcjmhzwV7xNXQ@mail.gmail.com>
References: <CAL=yMgVtrL0ZoSAp-=7kChv9vXkKDrALv+fgHAcP655km6WX+A@mail.gmail.com>
 <CAL=yMgWgEeK2ktxH2PLUD4Oo40wgwTPG-584d3DcX99DS8kyWA@mail.gmail.com>
 <s5h1u75vbf9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 21E3B265053
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:12:04 +0200 (CEST)
Received: by mail-wi0-f182.google.com with SMTP id m6so7458464wiv.15
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 05:12:03 -0700 (PDT)
In-Reply-To: <s5h1u75vbf9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Does any other input jack work with this card, i.e. the problem is
> only the mic jack?  And how doesn't it work?  It results in the
> complete static, getting any noise, or DMA stuck (thus no data)?
>

Thanks for responding,

This audio card has a shared analog line-in/mic, four analog out, optical
in and out. I was able to get a bit of audio to capture with the optical
audio(hw:4,1). The recording application is clearly getting a bitstream
from the analog (hw:4,0), but it is silence, with no static.

Ki'Sak
