From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] HDMI - fix ELD monitor name length
Date: Wed, 29 Jun 2011 14:31:53 +0800
Message-ID: <20110629063153.GA18118@localhost>
References: <20110629062607.GA17342@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id F2638246F4
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 08:31:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110629062607.GA17342@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi,

This fix should be confirming to the HDA spec, and works together with
the DRM part of the ELD patch.

The HDA spec does not mention that Monitor_Name_String is an '\0'
ending string, and it allows NML to be 1, which is only valid when MNL
does not count the possible ending '\0'.

Thanks,
Fengguang

On Wed, Jun 29, 2011 at 02:26:07PM +0800, Wu Fengguang wrote:
> I noticed that the last character of the ELD monitor name is lost,
> this fixes the issue.
> 
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> ---
>  sound/pci/hda/hda_eld.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- sound-2.6.orig/sound/pci/hda/hda_eld.c	2011-06-29 13:08:23.000000000 +0800
> +++ sound-2.6/sound/pci/hda/hda_eld.c	2011-06-29 14:13:25.000000000 +0800
> @@ -294,7 +294,7 @@ static int hdmi_update_eld(struct hdmi_e
>  		snd_printd(KERN_INFO "HDMI: out of range MNL %d\n", mnl);
>  		goto out_fail;
>  	} else
> -		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl);
> +		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl + 1);
>  
>  	for (i = 0; i < e->sad_count; i++) {
>  		if (ELD_FIXED_BYTES + mnl + 3 * (i + 1) > size) {
