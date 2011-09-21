From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Questions for dummy codec driver
Date: Wed, 21 Sep 2011 13:56:07 +0100
Message-ID: <20110921125607.GC25620@sirena.org.uk>
References: <1316502540.4269.1.camel@phoenix>
 <4E794A96.9040206@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C5B6E24C40
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 14:56:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E794A96.9040206@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leo Yan <leoy@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 21, 2011 at 10:23:18AM +0800, Leo Yan wrote:

> I have a question for the dummy codec.

Don't start new threads by randomly replying to unrelated mails.

> As you know, sometimes maybe we only need set the timing from the
> processor, and codec just only need tx/rx data; So there do not need
> the codec driver.

Even a dumb CODEC will have some constraints on things like the sample
rates it can support which need to be conveyed to the framework and
ideally the audio routing out of the CODEC should be visible for
integration with any external output drivers or similar.

> After browser the code, there have NO such a dummy codec driver; and
> for soc-core, there have not such flags to support this situation.
> Only what i get is sound/soc/codecs/spdif_transciever.c, but it's
> specific for TI's DaVinci platform.

Not at all, what makes you believe that it is platform specific?
