From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8903: add regulator handling
Date: Wed, 22 Mar 2017 09:06:20 +0000
Message-ID: <20170322090620.GC6986@localhost.localdomain>
References: <20170320091352.4115-1-linus.walleij@linaro.org>
 <20170320115155.GQ6986@localhost.localdomain>
 <CACRpkdbcudActZhifqUrb-4PFY0tTpNwt0TvpS4nUu6ptWPOJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E07F26696B
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 10:05:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACRpkdbcudActZhifqUrb-4PFY0tTpNwt0TvpS4nUu6ptWPOJw@mail.gmail.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 22, 2017 at 08:24:32AM +0100, Linus Walleij wrote:
> On Mon, Mar 20, 2017 at 12:51 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Mon, Mar 20, 2017 at 10:13:52AM +0100, Linus Walleij wrote:
> 
> >> Mark: I was thinking about adding runtime PM for disabling
> >> these regulators when unused, but I'm uncertain about the
> >> interaction with DAPM in that regard. This atleast gives us
> >> control over the supplies.
> >
> > DAPM will hold a pm_runtime reference whilst the chip is active
> > so usually there isn't really much interaction to worry about.
> 
> OK, so since the codec is registered on i2c's client->dev I take
> it I could use the runtime PM / suspend/resume callbacks on
> that device, and it should just work.
> 

Yeah should do, wm8962 should provide a reasonably similar model
if you are looking for a handy example and feel free to drop me a
line if I can be of any help.

Thanks,
Charles
