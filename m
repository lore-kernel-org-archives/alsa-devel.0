From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Fri, 29 Apr 2011 00:34:11 +0200
Message-ID: <4DB9EB63.5020007@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
	<4DB9E454.3060903@metafoo.de>
	<20110428221800.GC19535@opensource.wolfsonmicro.com>
	<20110428222315.GA19741@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id B509E2444F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:34:20 +0200 (CEST)
In-Reply-To: <20110428222315.GA19741@opensource.wolfsonmicro.com>
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

On 04/29/2011 12:23 AM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 11:18:00PM +0100, Mark Brown wrote:
>> On Fri, Apr 29, 2011 at 12:04:04AM +0200, Lars-Peter Clausen wrote:
>>> On 04/28/2011 11:48 PM, Mark Brown wrote:
> 
>>>> Moving to the card doesn't seem helpful, while we're currently doing one
>>>> update at once it's not immediately obvious that we want to keep doing
>>>> that indefinitely.
> 
>>> But keeping it in the dapm context would limit us to one update per context
>>> which doesn't seem very sustainable either.
> 
>> Though for global state changes like this that's pretty much irrelevant
>> as we need to walk the entire graph at once.
> 
> BTW, this means that my above comment was too hasty; I can't actually
> see a situation where we'd ever want to have multiple updates in flight.
> Though I also don't immediately see a need to move as the update gets
> applied to a specific context anyway ...

If we'd keep the update in the dapm context we'd have to iterate over all
contexts to find the one context which contains the update.
As you've said we have to walk the whole graph and it does not make a nice
interface if the function takes one specific dapm context while it works on the
whole card.

Currently we get the codec from the widget for which the update is run and not
from the dapm context anyway.

- Lars
