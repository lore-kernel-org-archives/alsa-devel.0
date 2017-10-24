From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ALSA: hda: Abort capability probe on
 invalid capability
Date: Tue, 24 Oct 2017 10:50:12 +0530
Message-ID: <20171024052011.GL936@localhost>
References: <1508849807-2250-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7129F267258
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 07:15:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1508849807-2250-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 24, 2017 at 06:26:47PM +0530, Rakesh Ughreja wrote:
> On reading wrong capability pointer values driver may crash, so whenever
> driver discovers unknown HDA capability, log it as error and stop traversing
> the link list further.

Acked-By: Vinod Koul <vinod.koul@intel.com>

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
