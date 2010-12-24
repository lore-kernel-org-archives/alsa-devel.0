From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc SND_SOC_DAPM_AIF_IN question
Date: Fri, 24 Dec 2010 11:35:58 +0000
Message-ID: <20101224113558.GB15474@opensource.wolfsonmicro.com>
References: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
	<20101222175503.GA27401@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C104C329@bgsmsx502.gar.corp.intel.com>
	<20101223112828.GA14481@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C104C6B6@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE4AA103938
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 12:35:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C104C6B6@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 23, 2010 at 06:31:08PM +0530, Koul, Vinod wrote:

> > "Audio Supply" sounds like the main analogue bias for the CODEC - that
> > would normally be managed by set_bias_level() rather than by having it
> > supply every single widget in the CODEC map.

> Yes that would make sense. But only for Audio rail which is global codec rail.
> What do you recommend for headset and speaker rails? They would be required only for headset and speaker DAI not rest.

Supplies for them seem sensible.

> > If you have multiple links between the CPU and the CODEC with a single
> > power bit to control them all I'd suggest defining several AIF widgets,
> > each with no power management, then making the actual power controlled
> > by a supply widget.  That way the power will be enabled as required but
> > you won't have tied all the data streams together in the DAPM map.

> Okay so then why should I do with several AIF widgets, wont doing that in DAI startup be a better idea?

Doing things via data rather than with explicit code tends to be lower
maintainance; there's less potential for things to go wrong and it's
usually less work to keep up to date with API changes.
