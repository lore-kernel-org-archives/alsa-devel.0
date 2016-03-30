From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] ALSA - hda: hdmi check NULL pointer in
 hdmi_set_chmap
Date: Wed, 30 Mar 2016 10:09:43 +0530
Message-ID: <20160330043942.GA14890@subhransu-desktop>
References: <1459307322-24655-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BD142605C3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 06:40:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1459307322-24655-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2016 at 08:38:42AM +0530, libin.yang@linux.intel.com wrote:
> From: Libin Yang <libin.yang@linux.intel.com>
> 
> Make sure per_pin is not NULL before using it.

Hi Libin,

In the beginning of ctl_put handler this NULL check is already done.
Are you supposed to call this set_chmap from other places too?

Regards,
Subhransu
> 
> Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 4833c7b..c99289d 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1858,6 +1858,8 @@ static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
>  	struct hdmi_spec *spec = codec->spec;
>  	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
>  
> +	if (!per_pin)
> +		return;
>  	mutex_lock(&per_pin->lock);
>  	per_pin->chmap_set = true;
>  	memcpy(per_pin->chmap, chmap, ARRAY_SIZE(per_pin->chmap));
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
