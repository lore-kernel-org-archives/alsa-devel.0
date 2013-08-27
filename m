From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: hda: Is it ok to enable SND_HDA_I915 to support
 Haswell Gfx power well by default?
Date: Tue, 27 Aug 2013 11:00:32 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013276C9@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F8013274C1@SHSMSX101.ccr.corp.intel.com>
 <521C7383.2040901@canonical.com> <s5hvc2rjw1o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 487072650F8
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 13:00:42 +0200 (CEST)
In-Reply-To: <s5hvc2rjw1o.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Would you please add " default y" to SND_HDA_I915?

Thanks
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 27, 2013 5:57 PM
> To: David Henningsson
> Cc: Lin, Mengdong; alsa-devel@alsa-project.org
> Subject: Re: hda: Is it ok to enable SND_HDA_I915 to support Haswell Gfx
> power well by default?
> 
> At Tue, 27 Aug 2013 11:38:11 +0200,
> David Henningsson wrote:
> >
> > On 08/27/2013 11:32 AM, Lin, Mengdong wrote:
> > > Hi Takashi and David,
> > >
> > >
> > >
> > > Is it okay to enable SND_HDA_I915 by default?
> >
> > I think it should be automatically enabled if the user has selected
> > both of snd-hda-intel and i915. And I thought it already was, but I
> > haven't checked so I might very well be wrong.
> 
> It's not set to default=y.  But, it'd be even easier to get rid of the user
> selection like below.
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig index
> 59c5e9c..8de66cc 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -152,14 +152,9 @@ config SND_HDA_CODEC_HDMI
>  	  This module is automatically loaded at probing.
> 
>  config SND_HDA_I915
> -	bool "Build Display HD-audio controller/codec power well support for i915
> cards"
> +	bool
> +	default y
>  	depends on DRM_I915
> -	help
> -	  Say Y here to include full HDMI and DisplayPort HD-audio
> controller/codec
> -	  power-well support for Intel Haswell graphics cards based on the i915
> driver.
> -
> -	  Note that this option must be enabled for Intel Haswell C+ stepping
> machines, otherwise
> -	  the GPU audio controller/codecs will not be initialized or damaged when
> exit from S3 mode.
> 
>  config SND_HDA_CODEC_CIRRUS
>  	bool "Build Cirrus Logic codec support"
