From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - restore BCLK M/N values when
 resuming HSW/BDW display controller
Date: Thu, 26 Jun 2014 09:49:37 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B580289@SHSMSX101.ccr.corp.intel.com>
References: <1403768236-3294-1-git-send-email-mengdong.lin@intel.com>
 <s5hha38vyz5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E1F2610C1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 11:49:49 +0200 (CEST)
In-Reply-To: <s5hha38vyz5.wl%tiwai@suse.de>
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

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, June 26, 2014 4:48 PM
 >
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
> 
> Can this be the cause of bko#74861?
>    https://bugzilla.kernel.org/show_bug.cgi?id=74861
> 

I think #74861 is the same problem as what we observe on Broadwell.

This problem is only for Haswell and Broadwell, which has a separate HD-A controller for display audio and convert HD-A link BCLK from display clock.

 
> This is HSW/BDW specific, so we should avoid adding new fields in struct
> azx.  Instead, define struct hda_intel in hda_intel.c,
> 
> 	struct hda_intel {
> 		struct azx chip;
> 
> 		/* HSW/BDW display HDA controller to restore BCLK from CDCLK
> */
> 		unsigned int bclk_m;
> 		unsigned int bclk_n;
> 	};
> 
> then change azx_create() to allocate struct hda_intel instead of struct azx.
> 
> 	struct hda_intel *hda;
> 
> 	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
> 	if (!hda) {
> 		...
> 	}
> 
> 	chip = &hda->chip;
> 	spin_lock_init(&chip->reg_lock);
> 	mutex_init(&chip->open_mutex);
> 	chip->card = card;
> 	...
> 
> and access to bclk_m and bclk_n via cast using container_of().
> 
> static void haswell_save_bclk(struct azx *chip) {
> 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
> 	hda->bclk_m = azx_readw(chip, EM4);
> 	hda->bclk_n = azx_readw(chip, EM5);
> }
> 
> 
> > +/* Intel HSW/BDW display HD-A controller Extended Mode registers.
> > + * EM4 (M value) and EM5 (N Value) are used to convert CDClk (Core
> > +Display
> > + * Clock) to 24MHz BCLK: BCLK = CDCLK * M / N
> > + * The values will be lost when the display power well is disabled.
> > + */
> > +#define ICH6_REG_EM4			0x100c
> > +#define ICH6_REG_EM5			0x1010
> 
> These are definitely not for ICH6.  Define them rather in hda_intel.c.
> 
> I'm going to move more other PCI-controller specific things from
> hda_priv.h into hda_intel.c, too.
> 
> Also, I guess this deserves for Cc to stable, right?

Yes, I agree. 
I'll revise the patch as you suggested. Many thanks for the review!

Mengdong
