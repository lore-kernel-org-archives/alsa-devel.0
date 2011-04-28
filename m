From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Fri, 29 Apr 2011 00:04:04 +0200
Message-ID: <4DB9E454.3060903@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F3492435F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:04:12 +0200 (CEST)
In-Reply-To: <20110428214817.GA19535@opensource.wolfsonmicro.com>
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

On 04/28/2011 11:48 PM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 11:24:38PM +0200, Lars-Peter Clausen wrote:
> 
>> Hm. I won't argue to death here. I could only repeat what I've said before.
>> But if we keep passing it indirectly we should at least make the struct opaque
>> to the world outside of soc-dapm and move the update pointer from
>> snd_soc_dapm_context to snd_soc_card.
> 
> Moving to the card doesn't seem helpful, while we're currently doing one
> update at once it's not immediately obvious that we want to keep doing
> that indefinitely.

But keeping it in the dapm context would limit us to one update per context
which doesn't seem very sustainable either.
Turning the pointer in the card struct into a list seems like an option though.

dapm_power_widgets works over the whole card, so the updates to be done should
in my opinion be kept on a per card basis as well.

- Lars
