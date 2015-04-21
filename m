From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 11:03:48 +0100
Message-ID: <1429610628.3793.23.camel@loki>
References: <1429217285.7100.18.camel@loki> <5535F513.8030902@ti.com>
 <20150421092812.GA22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BC1DE260709
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 12:03:54 +0200 (CEST)
In-Reply-To: <20150421092812.GA22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-04-21 at 10:28 +0100, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 09:58:27AM +0300, Peter Ujfalusi wrote:
> 
> > It is not entirely clear for me based on the first look, but who is
> > responsible to initiate the topology load? Is it the component or machine
> > driver? We have had issues with deferred probing when the component driver was
> > in charge of loading the firmware. I got around this by initiating the FW load
> > from the machine driver and via callbacks I notified the component driver to
> > take over from that point. This fixed the probe order and I can also handle
> > cases when the filesystem does not have the firmware so I can fall back to
> > 'legacy' mode.
> 
> Could you expand on those issues please?  I'd *really* not expect the
> machine driver to be involved in loading firmware for a component driver
> (think how this is going to affect generic drivers) and it's not obvious
> to me what impact this might have on deferred probe either.

The OMAP4 driver should not have any issues using the new topology code,
it's very generic :)

The topology code has moved to the component model so the ABE DSP driver
can load it's FW topology. If the FS is not available to load FW or
topology then you can wait until FS is ready (the upstream SST drivers
wait for FW to be ready before continuing with probing).

Liam
