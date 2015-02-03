From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [RFC PATCH] ASoC: wm8731: let codec to manage
	clock by itself
Date: Tue, 3 Feb 2015 15:40:45 +0100
Message-ID: <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 80395260439
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 15:41:26 +0100 (CET)
Received: by mail-wg0-f50.google.com with SMTP id b13so44824928wgh.9
 for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2015 06:41:26 -0800 (PST)
In-Reply-To: <20150203124441.GK21293@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Richard Purdie <richard@openedhand.com>, patches@opensource.wolfsonmicro.com, LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2015 at 1:44 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:
>
>> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
>> +    if (IS_ERR(wm8731->mclk)) {
>> +        wm8731->mclk = NULL;
>> +        dev_warn(&spi->dev, "assuming static MCLK\n");
>> +    }
>
> This is broken for both deferred probe and in the case where the clock
> API genuinely returns a NULL clock.  Other than that it's the kind of
> thing that we've done for some other drivers, though it's not good to
> have to do this.  Check them for correct behaviour.

Hm, so the only option is to create the simples possible 12MHz clk object?

Manuel
