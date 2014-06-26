From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - restore BCLK M/N values
 when resuming HSW/BDW display controller
Date: Thu, 26 Jun 2014 11:16:46 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B5803B1@SHSMSX101.ccr.corp.intel.com>
References: <cf161a8248cc08c0a3e1d9a59be572d1941fe2b6.1403779411.git.mengdong.lin@intel.com>
 <s5h7g44vt2d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1709A2619FA
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 13:16:56 +0200 (CEST)
In-Reply-To: <s5h7g44vt2d.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, June 26, 2014 6:55 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2] ALSA: hda - restore BCLK M/N values when
> resuming HSW/BDW display controller
> 
> At Thu, 26 Jun 2014 18:45:16 +0800,
> mengdong.lin@intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@intel.com>
> >
> > For Intel Haswell/Broadwell display HD-A controller, the 24MHz HD-A
> > link BCLK is converted from Core Display Clock (CDCLK): BCLK = CDCLK *
> > M / N And there are two registers EM4 and EM5 to program M, N value
> respectively.
> > The EM4/EM5 values will be lost and when the display power well is
> disabled.
> >
> > BIOS programs CDCLK selected by OEM and EM4/EM5, but BIOS has no
> idea
> > about display power well on/off at runtime. So the M/N can be wrong if
> > non-default CDCLK is used when the audio controller resumes, which
> > results in an invalid BCLK and abnormal audio playback rate. So this
> > patch saves and restores valid M/N values on controller
> suspend/resume.
> >
> > And 'struct hda_intel' is defined to contain standard HD-A 'struct
> > azx' and Intel specific fields, as Takashi suggested.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index bb65a124..ff9cacd 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -288,6 +288,24 @@ static char *driver_short_names[] = {
> >  	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",  };
> >
> > +
> > +/* Intel HSW/BDW display HDA controller Extended Mode registers.
> > + * EM4 (M value) and EM5 (N Value) are used to convert CDClk (Core
> > +Display
> > + * Clock) to 24MHz BCLK: BCLK = CDCLK * M / N
> > + * The values will be lost when the display power well is disabled.
> > + */
> > +#define ICH6_REG_EM4			0x100c
> > +#define ICH6_REG_EM5			0x1010
> 
> Avoid ICH6 prefix.  It's just confusing as these are only for HSW/BDW.
> 
> Other than that, looks good to me.
>

So how about adding these?

+#define HDMI_REG_EM4			0x100c
+#define HDMI_REG_EM5			0x1010

#define azx_hdmi_readw(chip, reg) \
	((chip)->ops->reg_readw((chip)->remap_addr + HDMI_REG_##reg))

#define azx_hdmi_writew(chip, reg, value) \
	((chip)->ops->reg_writew(value, (chip)->remap_addr + HDMI_REG_##reg))

static void haswell_save_bclk(struct azx *chip)
{
	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);

	hda->bclk_m = azx_hdmi_readw(chip, EM4);
	hda->bclk_n = azx_hdmi_readw(chip, EM5);
}

Or use "intel" instead of "hdmi", indicating it's Intel specific.

Thanks
Mengdong
