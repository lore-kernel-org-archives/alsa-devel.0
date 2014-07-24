From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel
	Braswell
Date: Thu, 24 Jul 2014 03:57:12 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19543D84@SHSMSX103.ccr.corp.intel.com>
References: <1406076938-97633-1-git-send-email-libin.yang@intel.com>
 <s5hwqb4jslx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0878D26573F
 for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2014 05:57:31 +0200 (CEST)
In-Reply-To: <s5hwqb4jslx.wl%tiwai@suse.de>
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

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, July 23, 2014 6:08 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong
> Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel Braswell
> 
> At Wed, 23 Jul 2014 08:55:37 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > Add HD Audio Device PCI ID for the Intel Braswell platform.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > ---
> >  sound/pci/hda/hda_intel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 387fc73..f758729 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2017,6 +2017,9 @@ static const struct pci_device_id azx_ids[] = {
> >  	/* BayTrail */
> >  	{ PCI_DEVICE(0x8086, 0x0f04),
> >  	  .driver_data = AZX_DRIVER_PCH |
> AZX_DCAPS_INTEL_PCH_NOPM },
> > +	/* Braswell */
> > +	{ PCI_DEVICE(0x8086, 0x2284),
> > +	  .driver_data = AZX_DRIVER_PCH |
> AZX_DCAPS_INTEL_PCH_NOPM },
> 
> Doesn't really this new chip support runtime PM?

Braswell is more like Baytrail, which doesn't support runtime PM. 

Anyway, I will test the pm-runtime on braswell and update the result later.

> 
> 
> Takashi
> 
> >  	/* ICH */
> >  	{ PCI_DEVICE(0x8086, 0x2668),
> >  	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
> > --
> > 1.9.1
> >

Regards,
Libin
