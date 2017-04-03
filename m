From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 18:53:07 -0300
Message-ID: <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 27EF5266972
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 23:53:08 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id b187so21962989oif.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 14:53:08 -0700 (PDT)
In-Reply-To: <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

On Mon, Apr 3, 2017 at 5:32 PM, Caleb Crome <caleb@crome.org> wrote:

> This patch definitely breaks the i.mx6 channel alignment.  In fact it
> breaks it so that the channels are never aligned properly.
>
> My test setup is as follows:
> * Get vanilla kernel, tag v4.11-rc5

Thanks for testing.

Just tested 4.11-rc5. It needs this additional patch:
https://patchwork.ozlabs.org/patch/745349/

otherwise pinctrl hog is broken and then sgtl5000 does not probe due
to the lack of MCLK.

I am using the original imx6dl-wandboard.dtb on my tests with no
hardware changes.

The test I am running is simple: just run the following script on the wandboard:

#!/bin/bash

while true
do
aplay swap_test.wav& sleep 1; killall aplay
done

You can get swap_test.wav file that consists of silence in the left
channel and none silence in the right channel from here:
https://www.dropbox.com/s/4zt0jvmtx34ic9x/swap_test.wav?dl=0

Then keep listening the left channel. In about one out of ten times
you will get non-silence there, indicating a swap.

> * apply a couple patches to allow AUD4 on the wandboard external
> connectors (and disable internal audio)
> * Test results:  v4.11-rc5 works flawlessly using Arnaud's atest
> program.  No channel slips, no issues at all.
> * Apply this patch, recompile, build.
> * Channel alignment fails.  The channels never get aligned properly.
>
> Am I right that the *only* change is this one-liner, and ignore the
> previous non V2 version of this patch?
>> -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
>> +               regmap_update_bits(regs, CCSR_SSI_SCR,
>> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
>> +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);

Yes, with only this change I do not get the swap anymore.

If you have a chance to run this method, please let me know how it goes.

Thanks
