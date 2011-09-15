From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Thu, 15 Sep 2011 11:26:43 +0100
Message-ID: <20110915102643.GE7988@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1316003710.3229.14.camel@odin> <4E7121DC.908@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 142CD244B9
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 12:26:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7121DC.908@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2011 at 04:51:24PM -0500, Timur Tabi wrote:

> >> +	i = snd_pcm_format_width(params_format(params));
> >> +	switch (i) {

> > Just a minor nitpick. I would not have used the intermediate 'i' here
> > and would have just embedded the snd_pcm call within the switch(). I
> > guess it may not fit the line width though.

> 'i' is used twice:

> 	switch (i) {

> and

> 	dev_err(codec->dev, "Unsupported sample size: %i\n", i);

There's no meaningful cost in calling the function twice and it'd be
much more legible to do so.
