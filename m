From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: snd-usb driver
Date: Wed, 11 Dec 2013 20:17:00 -0800
Message-ID: <52A938BC.1050804@gmail.com>
References: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 78B5326072A
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 05:17:08 +0100 (CET)
Received: by mail-pb0-f45.google.com with SMTP id rp16so11248959pbb.18
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 20:17:06 -0800 (PST)
In-Reply-To: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Takejame <lucas@takejame.com.br>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Lucas,

I wonder if I've misunderstood what you're trying to accomplish...

On 12/11/2013 08:59 AM, Lucas Takejame wrote:
> snd-usb driver). I know the code is already optimized but I was hoping
> that, since we only use one specific sound card and we won't need a generic
> driver, I could change something in the code to optimize it latency wise. I

Are you creating a product that *is* a USB sound card and you want to 
write a driver for it?

...or do you have some pre-existing USB sound card (and driver) that 
this product is using and you're trying to set up a low-latency audio 
workstation that uses it?

-gabe
