From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: Fix cards getting stuck in a
	powered state.
Date: Thu, 28 Apr 2011 20:52:21 +0100
Message-ID: <20110428195221.GD16837@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<20110428191533.GA16837@opensource.wolfsonmicro.com>
	<4DB9C440.7090201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADEF424141
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 21:52:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9C440.7090201@metafoo.de>
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

On Thu, Apr 28, 2011 at 09:47:12PM +0200, Lars-Peter Clausen wrote:
> On 04/28/2011 09:15 PM, Mark Brown wrote:

> > For CODECs we can easily add some widgets for them based on the DAI, for
> > cards we should just shove a random widget in there with the name of the
> > card, it doesn't need to be wired up to anything.

> For codecs we can use SND_SOC_DAPM_AIF_{IN,OUT} widgets.

Quite, but they do also need to be connected to outputs and inputs so
that they're part of complete paths.

> I don't understand you comment regarding cards though. It does not make sense
> to add a random widget which is not connected anywhere, since it either would
> have no effect or keep the card power up.

It minimises the risk of some other unexpected behaviour being noticed,
hopefully it's not needed but equally well if it's not needed it won't
do any harm and if it is needed it's obviously helpful.

> If we drop that special casing, we can handle widget-less context just fine,
> with the assumption that they don't need to be powered.

That's what's *supposed* to happen, certainly.
