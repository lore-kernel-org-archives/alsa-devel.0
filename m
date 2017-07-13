From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Thu, 13 Jul 2017 19:26:43 +0200
Message-ID: <CAMJBoFNxPsg8pjbWSc-vQQGKMPQOUQZ93=6NxY1YtzY1q16DfA@mail.gmail.com>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
 <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E14267264
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 19:26:45 +0200 (CEST)
Received: by mail-ua0-f181.google.com with SMTP id j53so38042275uaa.2
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 10:26:45 -0700 (PDT)
In-Reply-To: <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, trini@konsulko.com, Kevin Hilman <khilman@kernel.org>, Jyri Sarah <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

2017-07-13 10:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> + Peter & Jyri
>

<snip>

> While there are some users of davinci-evm.c, I think a majority are
> using simple-audio-card instead. Curious on why you chose not to use
> that. It sounds like codec is not the bitclock and frame-sync master in
> your case. Did that end up creating issues ?

Well, one of the problems with simple-audio-card is that you can't
snd_soc_dai_set_clkdiv() from it, neither you can set SND_SOC_CLK_OUT
for a codec, so for some codecs this just doesn't fit.

Best regards,
   Vitaly
