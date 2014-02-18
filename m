From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCHv2 3/5] ASoC: Intel: Add Intel SST audio DSP
 Firmware loader.
Date: Tue, 18 Feb 2014 08:47:51 +0000
Message-ID: <1392713271.2304.13.camel@loki>
References: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392643930-6030-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140218013510.GV2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 953E226514B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 09:47:55 +0100 (CET)
In-Reply-To: <20140218013510.GV2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Benson Leung <bleung@google.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-18 at 10:35 +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 01:32:08PM +0000, Liam Girdwood wrote:
> 
> > +	/* copy FW data to DMA-able memory */
> > +	memcpy((void *)sst_fw->dma_buf, (void *)fw->data, fw->size);
> 
> There aren't going to be any issues with alignment requirements for DMA
> with data within the firmware?

No, everything will be on 32bit boundaries.

Liam
