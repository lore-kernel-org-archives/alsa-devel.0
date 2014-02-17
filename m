From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCHv2 3/5] ASoC: Intel: Add Intel SST audio DSP
 Firmware loader.
Date: Mon, 17 Feb 2014 16:49:27 +0000
Message-ID: <1392655767.2390.23.camel@loki>
References: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392643930-6030-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5ha9dpzw72.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB7A26262D
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 17:49:32 +0100 (CET)
In-Reply-To: <s5ha9dpzw72.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@google.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-02-17 at 14:48 +0100, Takashi Iwai wrote:
> At Mon, 17 Feb 2014 13:32:08 +0000,
> Liam Girdwood wrote:

> > +	/* allocate DMA buffer to store FW data */
> > +	sst_fw->dma_buf = dma_alloc_coherent(dsp->dev, sst_fw->size,
> > +				&sst_fw->dmable_fw_paddr, GFP_DMA);
> 
> Missing GFP_KERNEL?
> 
> 

Yep thanks, I'll fix it incrementally if it's OK with Mark ?

Liam
