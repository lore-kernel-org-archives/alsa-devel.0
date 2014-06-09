From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] Revert "ALSA: hda - mask buggy stream
 DMA0 for Broadwell display controller"
Date: Mon, 9 Jun 2014 08:00:01 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952B716@SHSMSX103.ccr.corp.intel.com>
References: <1402298939-18377-1-git-send-email-libin.yang@intel.com>
 <s5hsinewn77.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CDB6261696
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 10:00:07 +0200 (CEST)
In-Reply-To: <s5hsinewn77.wl%tiwai@suse.de>
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

Got it. Thanks.

Regards,
Libin

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 9, 2014 3:35 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong
> Subject: Re: [PATCH 1/2] Revert "ALSA: hda - mask buggy stream DMA0 for
> Broadwell display controller"
> 
> At Mon,  9 Jun 2014 15:28:58 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > This reverts commit 7189eb9b8f7962474956196c301676470542f253.
> >
> > It will use LPIB to get the DMA position on Broadwell HDMI Audio.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> 
> Thanks, applied this with the next patch, but in a different order.
> In general, you shouldn't break things in the middle, especially for bisection.
> The second patch doesn't conflict with the DMA0 disablement, so we can
> apply it first, then revert DMA0 disablement.
> 
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_intel.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index cd77b9b..f93f338 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1367,12 +1367,6 @@ static int azx_first_init(struct azx *chip)
> >  	/* initialize streams */
> >  	azx_init_stream(chip);
> >
> > -	/* workaround for Broadwell HDMI: the first stream is broken,
> > -	 * so mask it by keeping it as if opened
> > -	 */
> > -	if (pci->vendor == 0x8086 && pci->device == 0x160c)
> > -		chip->azx_dev[0].opened = 1;
> > -
> >  	/* initialize chip */
> >  	azx_init_pci(chip);
> >  	azx_init_chip(chip, (probe_only[dev] & 2) == 0);
> > --
> > 1.8.3.2
> >
