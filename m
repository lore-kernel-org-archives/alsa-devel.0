From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Mon, 5 Dec 2011 13:46:11 +0000
Message-ID: <20111205134610.GO11150@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4EDC7A43.5040409@ti.com>
	<20111205113939.GF11150@opensource.wolfsonmicro.com>
	<4EDCC7E3.6060702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 283E0103ABA
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:46:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EDCC7E3.6060702@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 03:32:19PM +0200, Peter Ujfalusi wrote:
> On 12/05/2011 01:39 PM, Mark Brown wrote:

> > This increases the amount of time we are sitting with the pcm_mutex held
> > and I can't see a reason why we should need to do that.  If there is a
> > problem here I'd rather improve the drivers so that they can cope with
> > having the power management happening after the lock, the main reason
> > the drivers were doing this previously is that the lock happened to be
> > held by the caller.

> It is just that the pm_runtime calls might need the same protection as
> the other operations for dais/codecs/driver.

Well, the pcm_mutex doesn't cover all of those anyway (trigger and
pointer in particular) and we've no guarantee that anything will
actually happen at the point where the core does the calls as there may
be other things holding the device active.

> I just thought about this series, and it might broke the omap-mcpdm
> driver as soon as we have the BIAS_OFF support for the twl6040 codec
> driver. The functional clock is coming from the external codec. If we
> power down the external fclk we will see external abort crash, since the
> McPDM IP does not have the needed clocks at the time of the
> pm_runtime_put_sync call (which will try to configure some McPDM registers).
> Need to check this. Can we hold this series back for a while?

I don't understand how this could make the situation any worse than it
is already - if nothing else this series will only make the region where
we've got the device active slightly wider.  There's definitely an issue
there, but it seems like it already exists and is orthogonal to this
refactoring.  The McPDM needs to hold a reference on the CODEC somehow
while it is active it seems, either via DAPM or via the runtime_pm APIs.

Also note that as this is a reference counting API there's nothing
stopping any of the devices from being kept active independantly of
this, your use case would seem to be a good example of the sort of
situation where this might be useful.
