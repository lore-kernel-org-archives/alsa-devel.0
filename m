From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel
	Braswell
Date: Fri, 25 Jul 2014 13:21:30 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19544579@SHSMSX103.ccr.corp.intel.com>
References: <1406276356-131867-1-git-send-email-libin.yang@intel.com>
 <s5hlhrhalgi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B40462615EE
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 15:21:40 +0200 (CEST)
In-Reply-To: <s5hlhrhalgi.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Please see my comments below

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, July 25, 2014 4:31 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong
> Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel Braswell
> 
> At Fri, 25 Jul 2014 16:19:15 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > Add HD Audio Device PCI ID for the Intel Braswell platform.
> 
> So, you confirmed that runtime PM works?  Also, the device doesn't need
> the buffer size alignment unlike Haswell & co?  If these were already
> confirmed, describe in the patch description (also mention that it's an HDMI
> controller).
> 

Yes, I have tested the runtime PM, and it works. Besides, I think you are right, if the HDMI codec doesn't support, we should leave it to codec to decide not to use the runtime PM.

For the buffer size alignment, I will confirm with our HW team. Thanks for reminding me.

I will add the comments in the patch description. 

BTW: this is not a HDMI audio controller. The HDMI codec and analog codec will both connect to the controller. It's not embedded into the HDMI controller. 


> 
> Takashi
> 
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > ---
> >  sound/pci/hda/hda_intel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 387fc73..5db1948 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2017,6 +2017,9 @@ static const struct pci_device_id azx_ids[] = {
> >  	/* BayTrail */
> >  	{ PCI_DEVICE(0x8086, 0x0f04),
> >  	  .driver_data = AZX_DRIVER_PCH |
> AZX_DCAPS_INTEL_PCH_NOPM },
> > +	/* Braswell */
> > +	{ PCI_DEVICE(0x8086, 0x2284),
> > +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> >  	/* ICH */
> >  	{ PCI_DEVICE(0x8086, 0x2668),
> >  	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
> > --
> > 1.9.1
> >
