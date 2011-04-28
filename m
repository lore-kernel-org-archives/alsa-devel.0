From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Fri, 29 Apr 2011 00:58:30 +0200
Message-ID: <4DB9F116.9040305@metafoo.de>
References: <1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
	<4DB9E454.3060903@metafoo.de>
	<20110428221800.GC19535@opensource.wolfsonmicro.com>
	<20110428222315.GA19741@opensource.wolfsonmicro.com>
	<4DB9EB63.5020007@metafoo.de>
	<20110428224817.GA11103@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5422E1039CA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:58:47 +0200 (CEST)
In-Reply-To: <20110428224817.GA11103@opensource.wolfsonmicro.com>
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

On 04/29/2011 12:48 AM, Mark Brown wrote:
> On Fri, Apr 29, 2011 at 12:34:11AM +0200, Lars-Peter Clausen wrote:
>  ...
> 
>> Currently we get the codec from the widget for which the update is run and not
>> from the dapm context anyway.
> 
> That's just a redundancy in the data structure; the codec and context
> are just two different ways of getting to the same thing.

Yes, but the widget has a pointer to the dapm context as well. So we can get
the context from the widget and don't have to pass it separately. Or will there
be non-widget related updates, which ought to be done in the middle of the
powering sequence, in the foreseeable future?

- Lars
