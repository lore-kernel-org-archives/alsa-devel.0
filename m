From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: wm8903: add regulator handling
Date: Wed, 22 Mar 2017 08:24:32 +0100
Message-ID: <CACRpkdbcudActZhifqUrb-4PFY0tTpNwt0TvpS4nUu6ptWPOJw@mail.gmail.com>
References: <20170320091352.4115-1-linus.walleij@linaro.org>
 <20170320115155.GQ6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F96A2668D2
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 08:24:34 +0100 (CET)
Received: by mail-io0-f182.google.com with SMTP id f84so61441118ioj.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 00:24:34 -0700 (PDT)
In-Reply-To: <20170320115155.GQ6986@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 12:51 PM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Mon, Mar 20, 2017 at 10:13:52AM +0100, Linus Walleij wrote:

>> Mark: I was thinking about adding runtime PM for disabling
>> these regulators when unused, but I'm uncertain about the
>> interaction with DAPM in that regard. This atleast gives us
>> control over the supplies.
>
> DAPM will hold a pm_runtime reference whilst the chip is active
> so usually there isn't really much interaction to worry about.

OK, so since the codec is registered on i2c's client->dev I take
it I could use the runtime PM / suspend/resume callbacks on
that device, and it should just work.

> I think the patch looks fine for a first pass adding the supplies
> to me, someone can always add the suspend/resume and controlling
> the supplies across that when they need it.

I will make a try at this as a follow-on patch.

Yours,
Linus Walleij
