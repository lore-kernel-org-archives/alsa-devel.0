From: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH 1/5] ALSA: hda - Force polling mode on CNL
 for fixing codec communication
Date: Tue, 28 May 2019 00:10:02 +0000
Message-ID: <567A313375B6F043A9BE3A1D9B8C6E7F0B43C750@SHSMSX101.ccr.corp.intel.com>
References: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
 <s5ha7f89wm7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACA7FF8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 02:10:08 +0200 (CEST)
In-Reply-To: <s5ha7f89wm7.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Bard liao <yung-chuan.liao@linux.intel.com>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Yang,
 Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, May 27, 2019 3:37 PM
> To: Bard liao <yung-chuan.liao@linux.intel.com>
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org;
> liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Liao,
> Bard <bard.liao@intel.com>; Yang, Libin <libin.yang@intel.com>
> Subject: Re: [PATCH 1/5] ALSA: hda - Force polling mode on CNL for fixing codec
> communication
> 
> On Sun, 26 May 2019 18:58:32 +0200,
> Bard liao wrote:
> >
> > From: Bard Liao <yung-chuan.liao@linux.intel.com>
> >
> > We observed the same issue as reported by commit
> > a8d7bde23e7130686b7662
> > ("ALSA: hda - Force polling mode on CFL for fixing codec
> > communication") We don't have a better solution. So apply the same
> workaround to CNL.
> >
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> I think this should go to 5.2-rc, as it's a bug fix, so likely I'm going to take it soon
> later.
> 
> The question is about the rest patches.  The patches 2-4 are basically to move
> the polling handling into HDA-core, so they could be for 5.3.
> And patch 5 is for SOF.  This is still an open question.  If this SOF fix is needed for
> 5.2, all patches should go as well.

I am fine if patches 2-5 are for 5.3 :)

> 
> 
> thanks,
> 
> Takashi
> 
> 
> > ---
> >  sound/pci/hda/hda_intel.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 2ec91085fa3e..a93468ffb85c 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -375,6 +375,7 @@ enum {
> >
> >  #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device ==
> > 0x5a98)  #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device
> > == 0xa348)
> > +#define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device ==
> > +0x9dc8)
> >
> >  static char *driver_short_names[] = {
> >  	[AZX_DRIVER_ICH] = "HDA Intel",
> > @@ -1700,8 +1701,8 @@ static int azx_create(struct snd_card *card, struct
> pci_dev *pci,
> >  	else
> >  		chip->bdl_pos_adj = bdl_pos_adj[dev];
> >
> > -	/* Workaround for a communication error on CFL (bko#199007) */
> > -	if (IS_CFL(pci))
> > +	/* Workaround for a communication error on CFL (bko#199007) and
> CNL */
> > +	if (IS_CFL(pci) || IS_CNL(pci))
> >  		chip->polling_mode = 1;
> >
> >  	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
> > --
> > 2.17.1
> >
