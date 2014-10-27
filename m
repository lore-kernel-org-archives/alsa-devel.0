From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: Customizing simple audio card?
Date: Mon, 27 Oct 2014 13:15:52 +0300
Message-ID: <CAMo8BfJZf0FEgMWqUwamBr3_gZ17NXaSQDvH=peHbauok44eKg@mail.gmail.com>
References: <CAMo8BfLfMEwTqLnSt+WnzdrbRh0kh1hCYxj6u-xxwrKotiWx3Q@mail.gmail.com>
 <87lho21gah.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D8937260859
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 11:15:53 +0100 (CET)
Received: by mail-oi0-f45.google.com with SMTP id i138so3102921oig.32
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 03:15:52 -0700 (PDT)
In-Reply-To: <87lho21gah.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

Thanks for your reply.

On Mon, Oct 27, 2014 at 3:56 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Current simple-card already has mclk_fs support on hw_param.

Thought some more about it, indeed I can change my I2S master driver to just use
constant factor to derive MCLK frequency from the requested sample rate.

> So, we can add similar method ?
> Below is my idea. priv->xxx is new option here.

Hardcoding it seemed a bit awkward to me as well as providing full lookup table
to map sample rate to MCLK frequency in the device tree. So I'll stick with the
mclk_fs feature for now.

> Or you can update mclk_fs feature somehow ?

-- 
Thanks.
-- Max
