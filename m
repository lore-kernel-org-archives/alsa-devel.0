From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Tue, 18 Aug 2015 05:17:36 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D1B67@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de> <20150815155035.GG10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
 <1439807999.2420.25.camel@loki> <20150817200502.GZ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2955D2612AE
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 07:18:05 +0200 (CEST)
In-Reply-To: <20150817200502.GZ10748@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, August 18, 2015 4:05 AM
> To: Liam Girdwood
> Cc: Lars-Peter Clausen; tiwai@suse.de; alsa-devel@alsa-project.org; Lin,
> Mengdong
> Subject: Re: [alsa-devel] [PATCH v2 00/10] ASoC: support adding PCM
> dynamically from topology
> 
> On Mon, Aug 17, 2015 at 11:39:59AM +0100, Liam Girdwood wrote:
> 
> > The intention is that the topology data for BE and codec style links
> > is not to define the link (as this should come from DT or ACPI) but to
> > define the links config/capabilities for a given FW. e.g. we have two
> > different FWs that run BE0 (SSP0) with different number of channels
> > (one is stereo, the other is 4 channel TDM). Currently the link
> > definitions will be hard coded until the ACPI data is ready.
> 
> > The FE uses the above too for config/capabilities but it can also be
> > defined and created by the topology data (since it's a FW entity).
> 
> So this is actually for adding further constraints to the existing physical links,
> not just for defining new virtual links.  That is definitely a reasonable
> application but it seems like what we should be doing here is adding
> constraints to a fully defined link rather than just having a dummy link.  The
> link is real and there, it's just that we want to further restrict how it can be
> used.  Something that says "this is a dummy link" definitely feels wrong.

I feel it's not enough to just "adding constraints to a fully defined link" for FE DAIs.
We need to determine the number of FE DAIs (thus FE DAI links as well) for a specific version of FW based on its topology info.

We use a "dummy FE DAI link" in the Broadwell machine driver just to 
-  pass the soc_bind_dai_link() on registering the soc card and use the deferred probe mechanism;
-  pull in the platform component which carries topology the info

If you prefer not using any dummy DAI link but creating the links from scratch when we detect them in firmware, can we add new field into "struct snd_soc_card" to specify the components for topology? 
After all, topology may not only come from the platform component. 

Thanks
Mengdong
