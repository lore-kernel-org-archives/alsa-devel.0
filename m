From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
	cleanup
Date: Wed, 29 Mar 2017 14:38:23 +0300
Message-ID: <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 160C0266EFF
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:38:25 +0200 (CEST)
Received: by mail-it0-f67.google.com with SMTP id w11so1658588itb.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 04:38:25 -0700 (PDT)
In-Reply-To: <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, fabio.estevam@nxp.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 28, 2017 at 6:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 28, 2017 at 12:53:06PM +0100, Charles Keepax wrote:
>> On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
>
>> > >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>> > >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
>
>> > is different from &codec_dev->dev.
>
>> I get that they are different, I just don't get why changing
>> from a devm_clk_get to a clk_get is a better fix than changing
>> &codec->dev to &pdev->dev.
>
> This should be clear from the semantics of clk_get(): you're looking up
> the clock in the context of the supplied device and the clock is
> attached to the CODEC so you need to look up in the CODEC context.  What
> would be even better would be to move the allocation of the clock into
> the CODEC driver...

If I read the code correctly, both machine and codec driver are doing:

* codec_clk = clk_get(...)

I guess that the codec driver is the first to be loaded and it will call:

* __clk_create_clk

which will do the allocation. Then when machine driver is loaded, it
will only take a reference to the allocated clock.

I might be very wrong on this. Can you clarify what does moving allocation
of the clock into codec driver implies? Machine driver only needs a reference
to codec_clk to just get the clock's rate.

Daniel.
