From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 05/11] ASoC: hdac_hdmi: Add multichannel
 support
Date: Tue, 12 Apr 2016 19:06:33 +0530
Message-ID: <20160412133633.GB8655@subhransu-desktop>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
 <1460437293-8509-6-git-send-email-subhransu.s.prusty@intel.com>
 <570CE93D.6000109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C093E2651C9
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:37:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <570CE93D.6000109@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2016 at 07:25:33AM -0500, Pierre-Louis Bossart wrote:
> 
> -	/* Only stereo supported as of now */
> -	cvt->params.channels_min = cvt->params.channels_max = 2;
> +	chans = get_wcaps(hdac, cvt->nid);
> +	chans = get_wcaps_channels(chans);
> +
> +	cvt->params.channels_min = 2;
> +
> +	if (chans <= 16) {
> +		cvt->params.channels_max = chans;
> +		if (chans > hdmi->chmap.channels_max)
> +			hdmi->chmap.channels_max = chans;
> +	}t
> 
> 
> Are you sure about this? HDMI can only handle 8 channels in Layout
> 2. There's no support for 16 ch.

I copied this change form patch_hdmi.c. From the git history I couldn't
find why it is 16 ch. May be Takashi/Mengdong/Libin can confirm on this?

Regards,
Subhransu

> 

-- 
