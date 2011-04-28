From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: Fix cards getting stuck in a
	powered state.
Date: Fri, 29 Apr 2011 00:17:29 +0100
Message-ID: <20110428231728.GA11593@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<20110428191533.GA16837@opensource.wolfsonmicro.com>
	<4DB9C440.7090201@metafoo.de>
	<20110428195221.GD16837@opensource.wolfsonmicro.com>
	<4DB9F4B8.20602@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C4AC1039CA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:17:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9F4B8.20602@metafoo.de>
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

On Fri, Apr 29, 2011 at 01:14:00AM +0200, Lars-Peter Clausen wrote:

> I know this isn't optimal, but would it be accepable to have a
> SND_SOC_DAPM_STREAM(sname) widget, where the power_check function would just
> consider stream's state, so we can get rid of the special casing without having
> to mess with the codec drivers to much?

I was expecting that the core would just autogenerate some widgets for
the streams if it saw a CODEC appearing with no widgets in its context
after probe.  No code change to the CODEC drivers at all.

In principle a stream widget is fine, but you'd need ones for capture
and playback paths and they'd need to also function as pins so they can
be joined up with the outside world (which now we have multi-component
is a big reason to push back on things that don't do DAPM; it's not
purely about the annoyance of having to bodge around them).
