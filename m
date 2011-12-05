From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Mon, 05 Dec 2011 16:53:00 +0200
Message-ID: <4EDCDACC.1040409@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4EDC7A43.5040409@ti.com>
	<20111205113939.GF11150@opensource.wolfsonmicro.com>
	<4EDCC7E3.6060702@ti.com>
	<20111205134610.GO11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 2873C24482
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 15:53:10 +0100 (CET)
Received: by bkcjc3 with SMTP id jc3so949227bkc.3
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 06:52:56 -0800 (PST)
In-Reply-To: <20111205134610.GO11150@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On 12/05/2011 03:46 PM, Mark Brown wrote:
> Well, the pcm_mutex doesn't cover all of those anyway (trigger and
> pointer in particular) and we've no guarantee that anything will
> actually happen at the point where the core does the calls as there may
> be other things holding the device active.

It covers the soc_pcm_open, and soc_pcm_close sequences.

> I don't understand how this could make the situation any worse than it
> is already - if nothing else this series will only make the region where
> we've got the device active slightly wider.

The ordering of the pm_runtime_get/put will be different.
We will have the pm_runtime_put after all other parts of the audio
system has been closed, turned off.

> There's definitely an issue
> there, but it seems like it already exists and is orthogonal to this
> refactoring.  The McPDM needs to hold a reference on the CODEC somehow
> while it is active it seems, either via DAPM or via the runtime_pm APIs.

Yes, this is the reason we do not have the BIAS_OFF support in twl6040
still. I'm working on to integrate the external fclk (bit clock from
twl6040) for McPDM with pm_runtime so we are not going to have issues
with missing clocks.
But as I said at this time we do not have issues since the fclk for
McPDM is always present.
This change actually gives more incentive to do the pm_runtime support
for the McPDM external fclk ;)

-- =

P=E9ter
