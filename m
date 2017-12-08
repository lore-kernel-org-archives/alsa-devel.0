From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Change kern log level to avoid
	unwanted messages
Date: Fri, 8 Dec 2017 08:30:53 +0530
Message-ID: <20171208030051.GE32417@localhost>
References: <1512666160-30729-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3D4266D7D
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 03:57:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1512666160-30729-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, harshapriya.n@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 07, 2017 at 10:32:40PM +0530, Naveen Manohar wrote:
> patch suppresses the warning message "control load not supported"
> as this is a debug information to help debug issues in topology.

Just a note the some users have been complaining about this and this makes
the noise go away.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index a072bcf..81923da 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -2908,7 +2908,7 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
>  		break;
>  
>  	default:
> -		dev_warn(bus->dev, "Control load not supported %d:%d:%d\n",
> +		dev_dbg(bus->dev, "Control load not supported %d:%d:%d\n",
>  			hdr->ops.get, hdr->ops.put, hdr->ops.info);
>  		break;
>  	}
> -- 
> 1.9.1
> 

-- 
~Vinod
