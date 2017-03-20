From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8903: add regulator handling
Date: Mon, 20 Mar 2017 11:51:55 +0000
Message-ID: <20170320115155.GQ6986@localhost.localdomain>
References: <20170320091352.4115-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id F242B266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:50:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170320091352.4115-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 10:13:52AM +0100, Linus Walleij wrote:
> The WM8903 has four different voltage inputs: AVDD, CPVDD, DBVDD
> and DCVDD. On the Qualcomm APQ8060 Dragonboard these are all
> supplied from proper regulators and thus need activating and
> binding.
> 
> This is a quick-and-dirty solution just grabbing and enabling the
> regulator supplies on probe() and disabling them on remove() and
> the errorpath. More elaborate power management is likely possible.
> 
> I assume the nVidia designs using this codec have some hard-wired
> always-on power and will be happy with using the dummy regulators
> for this. But someone from the nVidia camp should probably check
> whether they can bind these to proper regulators instead.
> 
> We also amend the DT binding document. A small change like this
> does not warrant a separate patch for augmenting these.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mark: I was thinking about adding runtime PM for disabling
> these regulators when unused, but I'm uncertain about the
> interaction with DAPM in that regard. This atleast gives us
> control over the supplies.

DAPM will hold a pm_runtime reference whilst the chip is active
so usually there isn't really much interaction to worry about.

I think the patch looks fine for a first pass adding the supplies
to me, someone can always add the suspend/resume and controlling
the supplies across that when they need it.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
