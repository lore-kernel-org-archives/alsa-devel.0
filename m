From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2] ASoC: hdac_hdmi: Remove 'edev' NULL
	check
Date: Wed, 17 Feb 2016 17:38:18 +0530
Message-ID: <20160217120813.GA5008@subhransu-desktop>
References: <1455709333-19807-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 39EEF2606B8
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 13:07:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1455709333-19807-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2016 at 09:42:13AM -0200, Fabio Estevam wrote:
> Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting") 
> leads to the following Smatch complaint:
> 
> sound/soc/codecs/hdac_hdmi.c:971 hdac_hdmi_present_sense()
>          warn: variable dereferenced before check 'edev' (see line 967)
> 
> As explained by Subhransu S. Prusty:
> 
> "This NULL check is not required, can be removed.
> 
> edev object is expected to be present when the present_sense is 
> called. This is called from places where this edev object is 
> already available."
> 
> So remove the evdev NULL check.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

> ---
> Changes since v1:
> - Remove NULL check (Subhransu)
> 
>  sound/soc/codecs/hdac_hdmi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 36f1200..2884dbf 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -968,9 +968,6 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
>  	struct hdac_hdmi_pcm *pcm;
>  	int val;
>  
> -	if (!edev)
> -		return;
> -
>  	pin->repoll_count = repoll;
>  
>  	pm_runtime_get_sync(&edev->hdac.dev);
> -- 
> 1.9.1
> 

-- 
