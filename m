From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda_intel: add
	AZX_DCAPS_I915_POWERWELL for skl
Date: Fri, 27 Mar 2015 08:02:54 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19622F1C@SHSMSX103.ccr.corp.intel.com>
References: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
 <s5hfv8q98lm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F33A3260410
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 09:03:44 +0100 (CET)
In-Reply-To: <s5hfv8q98lm.wl-tiwai@suse.de>
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
> Sent: Friday, March 27, 2015 3:57 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: hda_intel: add
> AZX_DCAPS_I915_POWERWELL for skl
> 
> At Fri, 27 Mar 2015 15:10:04 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > HDMI/DP codec on SKL is in the power well.
> > The power well must be turned on before probing the
> > HDMI/DP codec.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> 
> So, was the previous question clarified?

Yes, I have confirmed with our silicon team.

> 
> This certainly sucks.  It means that the powerwell is on even you
> don't use the HDMI/DP at all.  If this is intended as a temporarily
> workaround, it should be mentioned so.  Please give more comments
> and
> backgrounds.

Yes, as this is added in the skl audio controller, even there is no HDMI/DP
codec, we should also add this flag. Otherwise the HDMI/DP codec
may not be detected correctly.

> 
> 
> thanks,
> 
> Takashi


Regards,
Libin
> 
> > ---
> >  sound/pci/hda/hda_intel.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 15a8299..4744a96 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -298,7 +298,8 @@ enum {
> >  	 AZX_DCAPS_SNOOP_TYPE(SCH))
> >
> >  #define AZX_DCAPS_INTEL_SKYLAKE \
> > -	(AZX_DCAPS_INTEL_PCH |
> AZX_DCAPS_SEPARATE_STREAM_TAG)
> > +	(AZX_DCAPS_INTEL_PCH |
> AZX_DCAPS_SEPARATE_STREAM_TAG |\
> > +	 AZX_DCAPS_I915_POWERWELL)
> >
> >  /* quirks for ATI SB / AMD Hudson */
> >  #define AZX_DCAPS_PRESET_ATI_SB \
> > --
> > 1.9.1
> >
