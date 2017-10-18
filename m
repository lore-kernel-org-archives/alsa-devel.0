From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ALSA: hda: Abort capability probe on
 invalid capability
Date: Wed, 18 Oct 2017 21:56:51 +0530
Message-ID: <20171018162651.GA30097@localhost>
References: <1508370325-3118-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B1E5266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:22:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1508370325-3118-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 05:15:25AM +0530, Ughreja, Rakesh A wrote:
> From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> 
> Due to bugs in BIOS it's possible that the HDA capability link

It maybe due to BIOS bug or some other issue, lets not quantify that please.

I would say "On reading wrong capablity pointer values we may crash...

> list is not constructed properly. This may lead to driver going
> into unknown state. 

I dont think we maintain driver states which are going wrong here

> So whenever driver discovers unknown HDA
> capability, log it as error and stop traversing the link list
> further.

that sound good

> 
> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> ---
>  sound/hda/hdac_controller.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
> index 978dc18..8f7d0d9 100644
> --- a/sound/hda/hdac_controller.c
> +++ b/sound/hda/hdac_controller.c
> @@ -314,7 +314,8 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
>  			break;
>  
>  		default:
> -			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
> +			dev_err(bus->dev, "Unknown capability %d\n", cur_cap);
> +			cur_cap = 0;
>  			break;
>  		}
>  
> -- 
> 2.7.4
> 

-- 
~Vinod
