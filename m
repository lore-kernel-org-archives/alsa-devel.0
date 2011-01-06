From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC sst v2: Add sn95031 codec driver
Date: Thu, 6 Jan 2011 13:45:41 +0000
Message-ID: <20110106134540.GA6328@opensource.wolfsonmicro.com>
References: <1294152367-8883-1-git-send-email-vinod.koul@intel.com>
	<20110105235652.GB5770@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C119C32E@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32991243F8
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 14:45:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C119C32E@bgsmsx502.gar.corp.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 12:17:04PM +0530, Koul, Vinod wrote:

> > > +	/* PCM interface config
> > > +	 * This sets the pcm rx slot conguration to max 6 slots
> > > +	 * for max 4 dais (2 stereo and 2 mono)
> > > +	 */

> > This stuff should all be dynamically configured at runtime - the clocks
> > should be being managed with set_sysclk() and the slot configuration
> > with the TDM API or dynamic routing depending on what the actual control
> > is.

> Since we have single PCM port and TDM slots. For all DAIs it needs to be single
> configuration and not changed while one is running.

It's a big jump to go from not being able to configure while active to
hard coding within the CODEC driver - machine drivers should be able to
change this sort of thing during initialisation, and ideally also
dynamically where possible (for example, only while there are no active
audio streams).
