From: "Singh, Guneshwor" <guneshwor.o.singh@intel.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Enable jack detection
 for Intel CFL + ALC700
Date: Wed, 15 Nov 2017 08:28:37 +0530
Message-ID: <20171115025837.GA20938@g2>
References: <20171114030008.858-1-guneshwor.o.singh@intel.com>
 <s5h8tf99bjm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CE726751C
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 03:58:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8tf99bjm.wl-tiwai@suse.de>
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
Cc: PeiSen Hou <pshou@realtek.com>, ALSA ML <alsa-devel@alsa-project.org>, kailang@realtek.com, CHLin <doomko@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 14, 2017 at 03:31:41PM +0100, Takashi Iwai wrote:
> On Tue, 14 Nov 2017 04:00:08 +0100,
> Guneshwor Singh wrote:
> > 
> > From: PeiSen Hou <pshou@realtek.com>
> > 
> > ALC700 has jack detection disabled by default in Intel Coffeelake
> > Reference board. To enable it, this fixup is required.
> > 
> > Signed-off-by: PeiSen Hou <pshou@realtek.com>
> > Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 0ce71111b4e3..61ef08173b1c 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5264,6 +5264,7 @@ enum {
> >  	ALC233_FIXUP_LENOVO_MULTI_CODECS,
> >  	ALC294_FIXUP_LENOVO_MIC_LOCATION,
> >  	ALC700_FIXUP_INTEL_REFERENCE,
> > +	ALC700_FIXUP_INTEL_CFL,
> >  };
> >  
> >  static const struct hda_fixup alc269_fixups[] = {
> > @@ -6074,6 +6075,21 @@ static const struct hda_fixup alc269_fixups[] = {
> >  			{}
> >  		}
> >  	},
> > +	[ALC700_FIXUP_INTEL_CFL] = {
> > +		.type = HDA_FIXUP_VERBS,
> > +		.v.verbs = (const struct hda_verb[]) {
> > +			/* Enables internal speaker */
> > +			{0x20, AC_VERB_SET_COEF_INDEX, 0x45},
> > +			{0x20, AC_VERB_SET_PROC_COEF, 0x5289},
> > +			{0x20, AC_VERB_SET_COEF_INDEX, 0x4a},
> > +			{0x20, AC_VERB_SET_PROC_COEF, 0x201b},
> 
> I see only one bit here is different from the previous quirk for Intel
> reference board.  Do we really need to keep both quirks separately?
> Or maybe this new one is the correct verb in anyway?
> 
> 

Will check if both are needed. Otherwise the same quirk can be reused
(by correcting the older verb if required). Thanks for the review.

> thanks,
> 
> Takashi
