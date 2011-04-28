From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ASoC: Fix cards getting stuck in a
	powered state.
Date: Thu, 28 Apr 2011 21:47:12 +0200
Message-ID: <4DB9C440.7090201@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<20110428191533.GA16837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 2195E2413F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 21:47:26 +0200 (CEST)
In-Reply-To: <20110428191533.GA16837@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/28/2011 09:15 PM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 06:46:07PM +0200, Lars-Peter Clausen wrote:
> 
>> This problem can arise if the card contains at least one widget-less DAPM
>> context.
> 
> No, this is getting silly.  We need to just make DAPM mandatory for all
> contexts - they get essentially no testing from people doing active
> development and the special casing they require is just a constant
> source of fragility.

I've thought about that. But I didn't wanted to break existing codec drivers.
As far as I can see there are at least 4 drivers in mainline code which do not
register any DAPM widgets, but provide set_bias_level callbacks:
wm8804.c, uda134x.c, stac9766.c, cq93vc.c

These would have to be updated.

> 
> For CODECs we can easily add some widgets for them based on the DAI, for
> cards we should just shove a random widget in there with the name of the
> card, it doesn't need to be wired up to anything.

For codecs we can use SND_SOC_DAPM_AIF_{IN,OUT} widgets.

I don't understand you comment regarding cards though. It does not make sense
to add a random widget which is not connected anywhere, since it either would
have no effect or keep the card power up.
The problem was not due to widget-less contexts per se, but due to the special
treatment they received regarding their power state.
As written in the commit message the power state was kept across multiple
dapm_power_widget calls while for normal context the power state was cleared at
the beginning of dapm_power_widget. So once a widget-less context was powered
it could not (easily) be powered down again, which as a result kept the whole
card powered.

If we drop that special casing, we can handle widget-less context just fine,
with the assumption that they don't need to be powered.

- Lars
