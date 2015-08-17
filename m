From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 17 Aug 2015 11:39:59 +0100
Message-ID: <1439807999.2420.25.camel@loki>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de> <20150815155035.GG10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C07E726061B
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 12:40:05 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-08-17 at 06:13 +0000, Lin, Mengdong wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]
> > Sent: Saturday, August 15, 2015 11:51 PM
> > To: Lars-Peter Clausen
> > Cc: Lin, Mengdong; alsa-devel@alsa-project.org; tiwai@suse.de; Girdwood,
> > Liam R
> > Subject: Re: [alsa-devel] [PATCH v2 00/10] ASoC: support adding PCM
> > dynamically from topology
> > 
> > On Sat, Aug 15, 2015 at 09:56:24AM +0200, Lars-Peter Clausen wrote:
> > 
> > > This all sounds as if the dynamically loaded topology information does
> > > not describe dynamic topology, e.g. like DSP firmware, but rather the
> > > static topology that would usually come from things like devicetree or
> > > ACPI. Maybe you need to rethink when the topology information is
> > > loaded and make sure that the parts that describe the static topology
> > > are available before the card is instantiated.
> > 
> > I do think that's some of it (as I said in my replies in the series), but I got the
> > impression from some other discussion that some of this was about
> > host<->DSP channels that exist purely in software which does seem like
> > something that could reasonably be in the topology, but this does seem more
> > like the fixed links stuff.
> 
> We hope to release different firmware for different OEM products. 
> Due to license restrictions, these firmware may have different features and may support different FE DAIs.
> 
> ACPI only describes physical links and does not handle FE DAIs. This is why we use topology here.
> 

To further clarify.

The intention is that the topology data for BE and codec style links is
not to define the link (as this should come from DT or ACPI) but to
define the links config/capabilities for a given FW. e.g. we have two
different FWs that run BE0 (SSP0) with different number of channels (one
is stereo, the other is 4 channel TDM). Currently the link definitions
will be hard coded until the ACPI data is ready.

The FE uses the above too for config/capabilities but it can also be
defined and created by the topology data (since it's a FW entity).

Liam
