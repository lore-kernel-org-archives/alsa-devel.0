From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: Add AZX_DCAPS_I915_POWEREWELL on SKL is OK?
Date: Thu, 26 Mar 2015 06:54:21 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1962290E@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1962288A@SHSMSX103.ccr.corp.intel.com>
 <s5h619o9sqz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D2442604DD
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 07:55:31 +0100 (CET)
In-Reply-To: <s5h619o9sqz.wl-tiwai@suse.de>
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
> Sent: Thursday, March 26, 2015 2:29 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org
> Subject: Re: Add AZX_DCAPS_I915_POWEREWELL on SKL is OK?
> 
> At Thu, 26 Mar 2015 05:40:20 +0000,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > Is it OK to add AZX_DCAPS_I915_POWEREWELL for SKL in hda_intel.c?
> >
> > SKL HDA controller is not in powerwell domain. But its
> > HDMI codec is in the domain. My understanding is if the flag
> > is added here, it means the controller is in the domain. But I can't
> > find a good place to add a flag to indicate the HDMI codec need
> > the power domain.
> 
> The question is when you need the powerwell enable/disable.
> If the powerwell has to be adjusted before *any* HDMI codec access,
> we'd need this even at probing the codec.  Currently HD-audio
> controller driver probes a codec by reading VENDOR_ID parameter of
> the
> root node.  This was supposed to work even at codec D3, except for
> Intel HDMI controllers.
> 
> Now, HDMI codec is on the common bus on SKL.  Does this mean that
> reading the root node parameter works even without powerwell?
> This has to be clarified at first.  I asked this in the last meeting,
> but it seems still unclear.
> 
> If the root node parameter can be read without powerwell, then the
> controller doesn't need it.  Instead, a similar code needs to be added
> in the HDMI codec side.  OTOH, if the root parameter reads already
> requires the powerwell, then yes, we need to add the DCAPS to the
> controller.
> 


Thanks. I will confirm with our internal silicon team for your question.

> 
> Takashi
