From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Dereference 'edev' after
 checking for NULL
Date: Wed, 17 Feb 2016 14:51:52 +0530
Message-ID: <20160217092147.GA3769@subhransu-desktop>
References: <1455700199-18691-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C176F26047F
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 10:20:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1455700199-18691-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2016 at 07:09:59AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting") 
> leads to the following Smatch complaint:
> 
> sound/soc/codecs/hdac_hdmi.c:971 hdac_hdmi_present_sense()
>          warn: variable dereferenced before check 'edev' (see line 967)
> 
> ,so deference 'edev' after checking for NULL.

This NULL check is not required, can be removed.

edev object is expected to be present when the present_sense is called. This
is called from places where this edev object is already available. 

Regards,
Subhransu

> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 36f1200..920af2f 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -964,13 +964,15 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
>  static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
>  {
>  	struct hdac_ext_device *edev = pin->edev;
> -	struct hdac_hdmi_priv *hdmi = edev->private_data;
> +	struct hdac_hdmi_priv *hdmi;
>  	struct hdac_hdmi_pcm *pcm;
>  	int val;
>  
>  	if (!edev)
>  		return;
>  
> +	hdmi = edev->private_data;
> +
>  	pin->repoll_count = repoll;
>  
>  	pm_runtime_get_sync(&edev->hdac.dev);
> -- 
> 1.9.1
> 

-- 
