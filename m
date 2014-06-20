From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Fri, 20 Jun 2014 10:04:51 +0200
Message-ID: <53A3EB23.4050302@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-238.synserver.de
 [212.40.185.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B9CD2610AA
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 10:04:51 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/13/2014 02:33 PM, Vinod Koul wrote:
> Here is the split patch series for adding DSP support for Intel's merrfield
> platform.
>
> The last patch si mxer update patch which we have been discussing over the list.
> This is only for discussion and sake of complteness. For that patch we need the
> dapm_kcontrol_get/set series to do merged OR patch to be reworked after
> compenent series

Hi,

Some general feedback on this series.

You are often accessing data structures which are more or less internal to 
the DAPM core, all without doing any of the necessary locking. Those are in 
particular the widget and path structures. This access in the driver will 
make it harder to make modifications to the core as you'd not only 
understand the core but also the special semantics that this driver puts on 
those data structures. If you think the core does not provide what you need 
try to extend the core with helper functions, with well defined semantics, 
that do what you need.

Also this series is a bit of a step backwards in terms of 
compartmentalization as it re-introduces things that we've been trying to 
get rid of over the last few months:
  * Don't access widget->platform or dapm->platform, use 
snd_soc_dapm_to_platform()
* Don't access dai->platform, use rtd->platform.
* Use regmap for IO instead of the read/write callbacks in the 
platform_driver struct.

- Lars
