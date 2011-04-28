From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 21:58:27 +0100
Message-ID: <20110428205827.GA18350@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 822AE243AC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 22:58:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9D06C.5090006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 10:39:08PM +0200, Lars-Peter Clausen wrote:
> On 04/28/2011 09:40 PM, Mark Brown wrote:

> > If we're going to do something like this it would be better to make the
> > update a more complex object so we weren't passing the stream update
> > separately.  The update should be "what we're doing right now" which
> > includes the stream operation. [...]

> Hm... the current update struct only contains information on register updates,
> since we don't not always want to update a register when we sent a stream event
> and vice versa it does make sense to keep them separate.

Sure, but we've already got a perfectly good way of representing no
register which we can use.  No big deal there.

> > TBH I'm not sure how much of a help I find this, it's nice to not have
> > to pass the operation we're doing about all the time especially if we
> > end up using more context information in the middle of the operation
> > (which I suspect we may end up doing).  You still have to work back
> > through the call chain to find where the data came from.

> Well, but you know that it is a parameter to the function call. With the
> current scheme you don't know this immediately. Right now dapm->update is some
> random global variable and it is not quite clear that it is only valid for the
> time dapm_power_widgets is called.

It should be valid at any time, it's cleared after use.  It only makes
sense when something is in the middle of doing an update.  Half of the
thing for me is that we can now grep for actual users without seeing
things that are just bouncing the data around.
