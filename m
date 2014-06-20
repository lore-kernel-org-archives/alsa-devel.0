From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Fri, 20 Jun 2014 13:50:41 +0530
Message-ID: <20140620082041.GG22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <53A3EB23.4050302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D97D72619DB
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 10:20:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53A3EB23.4050302@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 20, 2014 at 10:04:51AM +0200, Lars-Peter Clausen wrote:
> On 06/13/2014 02:33 PM, Vinod Koul wrote:
> >Here is the split patch series for adding DSP support for Intel's merrfield
> >platform.
> >
> >The last patch si mxer update patch which we have been discussing over the list.
> >This is only for discussion and sake of complteness. For that patch we need the
> >dapm_kcontrol_get/set series to do merged OR patch to be reworked after
> >compenent series
> 
> Hi,
> 
> Some general feedback on this series.
Thanks a bunch for that :)
> 
> You are often accessing data structures which are more or less
> internal to the DAPM core, all without doing any of the necessary
> locking. Those are in particular the widget and path structures.
> This access in the driver will make it harder to make modifications
> to the core as you'd not only understand the core but also the
> special semantics that this driver puts on those data structures. If
> you think the core does not provide what you need try to extend the
> core with helper functions, with well defined semantics, that do
> what you need.
> 
> Also this series is a bit of a step backwards in terms of
> compartmentalization as it re-introduces things that we've been
> trying to get rid of over the last few months:
Well the series was developed on 3.10 and forward ported for upstreaming. So yes
you can get that feel. I will try to clean these bits up. Where ever missed
please do point it out.

>  * Don't access widget->platform or dapm->platform, use
> snd_soc_dapm_to_platform()
> * Don't access dai->platform, use rtd->platform.
Will update above two

> * Use regmap for IO instead of the read/write callbacks in the
> platform_driver struct.
I dont think we need that for our DSP. The read/write are writing to driver
memory which is later used to send data to DSP using IPCs. So how will regmap
help here?

-- 
~Vinod
