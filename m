From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 17 Aug 2015 06:13:23 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de> <20150815155035.GG10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C6726053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 08:14:14 +0200 (CEST)
In-Reply-To: <20150815155035.GG10748@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, August 15, 2015 11:51 PM
> To: Lars-Peter Clausen
> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; tiwai@suse.de; Girdwood,
> Liam R
> Subject: Re: [alsa-devel] [PATCH v2 00/10] ASoC: support adding PCM
> dynamically from topology
> 
> On Sat, Aug 15, 2015 at 09:56:24AM +0200, Lars-Peter Clausen wrote:
> 
> > This all sounds as if the dynamically loaded topology information does
> > not describe dynamic topology, e.g. like DSP firmware, but rather the
> > static topology that would usually come from things like devicetree or
> > ACPI. Maybe you need to rethink when the topology information is
> > loaded and make sure that the parts that describe the static topology
> > are available before the card is instantiated.
> 
> I do think that's some of it (as I said in my replies in the series), but I got the
> impression from some other discussion that some of this was about
> host<->DSP channels that exist purely in software which does seem like
> something that could reasonably be in the topology, but this does seem more
> like the fixed links stuff.

We hope to release different firmware for different OEM products. 
Due to license restrictions, these firmware may have different features and may support different FE DAIs.

ACPI only describes physical links and does not handle FE DAIs. This is why we use topology here.

Thanks
Mengdong 
