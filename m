From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 16:31:59 -0700
Message-ID: <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <20170403220811.GA21156@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AB6266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 01:32:20 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id j137so20590159vke.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 16:32:20 -0700 (PDT)
In-Reply-To: <20170403220811.GA21156@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 3, 2017 at 3:08 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Mon, Apr 03, 2017 at 01:32:42PM -0700, Caleb Crome wrote:
>
>> This patch definitely breaks the i.mx6 channel alignment.  In fact it
>> breaks it so that the channels are never aligned properly.
>>
>> My test setup is as follows:
>> * Get vanilla kernel, tag v4.11-rc5
>> * apply a couple patches to allow AUD4 on the wandboard external
>> connectors (and disable internal audio)
>> * Test results:  v4.11-rc5 works flawlessly using Arnaud's atest
>> program.  No channel slips, no issues at all.
>> * Apply this patch, recompile, build.
>> * Channel alignment fails.  The channels never get aligned properly.
>
> What's your test case for the alignment?

I'm not sure what you are asking.  The test case I'm testing is:
connect SSI to AUD4 on wandboard & physically connect TX -> RX.  (as
per https://github.com/ccrome/linux-caleb-dev/wiki), then use atest to
verify bit-perfection of TX->RX transmission.

Also, you must use a scope on the pins to verify that TX is also in
the right location (i.e. it's possible that bot TX and RX are rotated
by the same number of samples, thus you could be fooled by a
software-only test).

> IIRC, you only needed
> the FIFO to be pre-filled with data input so that SSI will not
> encounter any FIFO underrun after enabling TE bit. That's why
> there is a for-loop before this regmap_update_bits().

Well, there was more to it than that IIRC.  There were several patches
that made it all hang together.

>
>> Am I right that the *only* change is this one-liner, and ignore the
>> previous non V2 version of this patch?
>> > -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
>> > +               regmap_update_bits(regs, CCSR_SSI_SCR,
>> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
>> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
>
> However, this patch seems to merely set the RE bit. It shouldn't
> affect that test case since the SSIEN bit is still set prior to
> the TE bit.

Heh, well, this patch causes audio to be utterly broken on
multi-channel audio :-/

-Caleb
