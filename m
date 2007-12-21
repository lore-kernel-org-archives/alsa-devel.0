From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Fri, 21 Dec 2007 00:28:40 -0500
Message-ID: <75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<s5h4ped4gl3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A9322437E
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 06:28:42 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so118484rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 21:28:40 -0800 (PST)
In-Reply-To: <s5h4ped4gl3.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Dec 20, 2007 8:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 20 Dec 2007 08:24:35 -0600,
> Timur Tabi wrote:
> >
> > >> +static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
> > >> +  struct snd_pcm *pcm)
> > >> +{
> > >> +  static u64 fsl_dma_dmamask = 0xffffffff;
> > >> +  int ret;
> > >> +
> > >> +  if (!card->dev->dma_mask)
> > >> +          card->dev->dma_mask = &fsl_dma_dmamask;
> > >
> > > I haven't read how your channel allocation works, but providing a
> > > pointer to a local static variable is a bit fishy no matter what.
> >
> > I just copied this code from another module.  All the ALSA drivers do this,
>
> All?  No, only a few...
> For PCI, usually pci_set_dma_mask() and pci_set_consistent_dma_mask()
> are used, of course.

Timur,

Nicely commented driver!  I wish they were all like this ;-)

Please use DMA_32BIT_MASK (see include/linux/dma-mapping.h) instead of
0xffffffff.  I've personally fixed a heisenbug in an ALSA driver
caused by incorrectly typed DMA mask...

Lee
