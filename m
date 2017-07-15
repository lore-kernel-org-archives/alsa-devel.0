From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Sat, 15 Jul 2017 07:10:29 +0200
Message-ID: <CAMJBoFNKzM7Wv64TyRiBSG5V2Tr_mq=6VuocabLSrn_LBHckMA@mail.gmail.com>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
 <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
 <20170713103338.cu5emql5vnalsamw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
 [209.85.217.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 151352669F3
 for <alsa-devel@alsa-project.org>; Sat, 15 Jul 2017 07:10:30 +0200 (CEST)
Received: by mail-ua0-f195.google.com with SMTP id z22so5416368uah.0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 22:10:30 -0700 (PDT)
In-Reply-To: <20170713103338.cu5emql5vnalsamw@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, trini@konsulko.com, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Jyri Sarah <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

2017-07-13 12:33 GMT+02:00 Mark Brown <broonie@kernel.org>:
> On Thu, Jul 13, 2017 at 01:31:25PM +0530, Sekhar Nori wrote:
>
>> While there are some users of davinci-evm.c, I think a majority are
>> using simple-audio-card instead. Curious on why you chose not to use
>> that. It sounds like codec is not the bitclock and frame-sync master in
>> your case. Did that end up creating issues ?
>
> New systems should start using of-graph - that's a more flexible and
> extensible replacement for simple-card.  But yes, if you can use one of
> the generic cards that's better.

Unfortunately I can't. In fact we have a few DM81xx devices which boot
nicely using the existing kernel code and have most of the peripherals
working fine, but sound is not working even though all the relevant
drivers are in place. I believe that unless davinci-evm is deprecated,
it is beneficial for everyone to have it supporting DM81xx (and I can
take over its maintenance since the current maintainer has invalid
e-mail specified in the header). I'll be working on of-graph version,
too, but Rome wasn't built in a day, you know :)

Best regards,
   Vitaly
