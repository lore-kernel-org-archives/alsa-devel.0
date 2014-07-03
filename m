From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda - restore BCLK M/N value as
 per CDCLK for HSW/BDW display HDA controller
Date: Thu, 3 Jul 2014 05:14:11 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B5898FE@SHSMSX101.ccr.corp.intel.com>
References: <cover.1404311751.git.mengdong.lin@intel.com>
 <54aede59c2ab488ffff3c92c45798efb38a5e0d2.1404311751.git.mengdong.lin@intel.com>
 <s5hr4234xg1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B2292657F4
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 07:14:15 +0200 (CEST)
In-Reply-To: <s5hr4234xg1.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Nikula, Jani" <jani.nikula@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for your review! The revised patches are submitted: 
[PATCH v2 1/2] drm/i915: provide interface for audio driver to query cdclk
[PATCH v2 2/2] ALSA: hda - restore BCLK M/N value as per CDCLK for HSW/BDW display HDA controller

And we think these patches may have Cc to stable, since Haswell need them.

Hi Jani,

Your first patch was also submitted to Intel gfx mailing list. Thanks for your help on this issue!

Regards
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, July 02, 2014 11:01 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; Nikula, Jani
> Subject: Re: [PATCH 3/3] ALSA: hda - restore BCLK M/N value as per CDCLK
> for HSW/BDW display HDA controller
> 
> At Wed,  2 Jul 2014 22:44:07 +0800,
> mengdong.lin@intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@intel.com>
> >
> > For HSW/BDW display HD-A controller, this patch restores BCLK by
> > setting the M/N values as per the core display clock (CDCLK) queried
> > from i915 display driver.
> >
> > And the audio driver will also restore BCLK in azx_first_init() since
> > the display driver can turn off the shared power in boot phase if only
> > eDP is connected and M/N values will be lost and must be
> reprogrammed.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 25753db..c7dfd1d 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -299,10 +299,6 @@ static char *driver_short_names[] = {
> >
> >  struct hda_intel {
> >  	struct azx chip;
> > -
> > -	/* HSW/BDW display HDA controller to restore BCLK from CDCLK */
> > -	unsigned int bclk_m;
> > -	unsigned int bclk_n;
> >  };
> >
> >
> > @@ -598,20 +594,41 @@ static int param_set_xint(const char *val,
> const
> > struct kernel_param *kp)  #define azx_del_card_list(chip) /* NOP */
> > #endif /* CONFIG_PM */
> >
> > -static void haswell_save_bclk(struct azx *chip) -{
> > -	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
> > -
> > -	hda->bclk_m = azx_readw(chip, EM4);
> > -	hda->bclk_n = azx_readw(chip, EM5);
> > -}
> >
> >  static void haswell_restore_bclk(struct azx *chip)  {
> > -	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
> > +	int cdclk_freq;
> > +	unsigned int bclk_m, bclk_n;
> > +
> > +	cdclk_freq = hda_get_display_clk();
> > +	switch (cdclk_freq) {
> > +	case 337500:
> > +		bclk_m = 16;
> > +		bclk_n = 225;
> > +		break;
> > +
> > +	case 450000: /* default CDCLK 450MHz */
> > +		bclk_m = 4;
> > +		bclk_n = 75;
> > +		break;
> > +
> > +	case 540000:
> > +		bclk_m = 4;
> > +		bclk_n = 90;
> > +		break;
> > +
> > +	case 675000:
> > +		bclk_m = 8;
> > +		bclk_n = 225;
> > +		break;
> >
> > -	azx_writew(chip, EM4, hda->bclk_m);
> > -	azx_writew(chip, EM5, hda->bclk_n);
> > +	default:
> > +		bclk_m = 4;
> > +		bclk_n = 75;
> 
> You can put "default:" around "case 45000:", and move the comment
> about default CDCLK there.
> 
> > +	}
> > +
> > +	azx_writew(chip, EM4, bclk_m);
> > +	azx_writew(chip, EM5, bclk_n);
> >  }
> 
> IMO, the whole function can be moved to hda_i915.c and provided as a
> function such as hda_set_display_clk().  Then you can drop
> hda_get_display_clk() but call get_cdclk() internally.
> 
> Also, all these patches may have Cc to stable, right?
> 
> 
> thanks,
> 
> Takashi
