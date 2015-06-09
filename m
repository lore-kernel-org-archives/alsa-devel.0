From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - PCH HDA controller not
 controlled by i915 power
Date: Tue, 9 Jun 2015 08:43:44 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19669ECF@SHSMSX103.ccr.corp.intel.com>
References: <1433829918-5807-1-git-send-email-libin.yang@intel.com>
 <s5h1thlbder.wl-tiwai@suse.de>	<55768BCB.3060001@canonical.com>
 <s5hy4jt9td4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 060122606CD
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 10:43:51 +0200 (CEST)
In-Reply-To: <s5hy4jt9td4.wl-tiwai@suse.de>
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

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, June 09, 2015 4:30 PM
> To: David Henningsson
> Cc: Yang, Libin; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - PCH HDA controller not
> controlled by i915 power
> 
> At Tue, 09 Jun 2015 08:46:35 +0200,
> David Henningsson wrote:
> >
> >
> >
> > On 2015-06-09 08:31, Takashi Iwai wrote:
> > > At Tue,  9 Jun 2015 14:05:18 +0800,
> > > libin.yang@intel.com wrote:
> > >>
> > >> From: Libin Yang <libin.yang@intel.com>
> > >>
> > >> On some Intel platforms, the HDMI codec is connected to PCH
> HDA
> > >> controller. In this case, AZX_DCAPS_I915_POWERWELL is set and
> > >> the i915 power well failure should not block the hda controller
> > >> initialization.
> > >>
> > >> Signed-off-by: Libin Yang <libin.yang@intel.com>
> > >
> > > Is this fix needed for 4.1, or it's only for 4.2?
> >
> > It's a bug fix, and as such should go to all kernels, even with cc to
> > stable. That said, it mainly concerns Skylake, so kernels that don't
> > support Skylake would not need a backport.
> 
> The patch can't be applied even to 4.1 as is because of the code
> structure change.  So, Cc to stable doesn't work, in anyway.
> 
> > > I vaguely remember of a bug report.  If there is any relevant bug
> > > report, please give the link, too.
> >
> > I think this was raised to Intel by us. The use case is when the
> > integrated GPU is disabled and a discrete GPU is used. In this case
> the
> > i915 module fails to load. If then the HDMI and analog codec are both
> on
> > the same controller, the entire controller fails instead of just the
> > HDMI codec.

I can't find the bug number, maybe David can help.

BTW: Not only SKL but also other platforms that controller is not in 
Powerwell while the controller connects with HDMI codec will meet
such issue, like BSW.

> >
> > I'll see if I can get the patch tested ASAP.
> 
> OK, the bug seems needed for 4.1 and earlier.  But Libin's patch is
> only for 4.2.  And even worse, backporting this isn't
> straightforward due to the lack of need_i915_power field.  Hmm.
> 
> I think we can make it easier by just allowing to continue the probe.
> A totally untested patch for 4.1 is below.

Thanks for your help on this. So this patch will be merged or we will
wait for 4.2 to merge the patch?

> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index fea198c58196..3903a62ce1e8 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -340,6 +340,11 @@ enum {
>  #define use_vga_switcheroo(chip)	0
>  #endif
> 
> +#define CONTROLLER_IN_GPU(pci) (((pci)->device == 0x0a0c) || \
> +					((pci)->device == 0x0c0c) || \
> +					((pci)->device == 0x0d0c) || \
> +					((pci)->device == 0x160c))
> +
>  static char *driver_short_names[] = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
>  	[AZX_DRIVER_PCH] = "HDA Intel PCH",
> @@ -1854,8 +1859,12 @@ static int azx_probe_continue(struct azx
> *chip)
>  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
>  #ifdef CONFIG_SND_HDA_I915
>  		err = hda_i915_init(hda);
> -		if (err < 0)
> -			goto out_free;
> +		if (err < 0) {
> +			if (CONTROLLER_IN_GPU(pci))
> +				goto out_free;
> +			else
> +				goto skip_i915;
> +		}
>  		err = hda_display_power(hda, true);
>  		if (err < 0) {
>  			dev_err(chip->card->dev,
> @@ -1865,6 +1874,7 @@ static int azx_probe_continue(struct azx
> *chip)
>  #endif
>  	}
> 
> + skip_i915:
>  	err = azx_first_init(chip);
>  	if (err < 0)
>  		goto out_free;
