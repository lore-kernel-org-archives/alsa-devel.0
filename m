From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 4/5] ASoC: sst_platform: fix the pulseaudio
 error
Date: Tue, 15 Feb 2011 20:56:54 +0530
Message-ID: <1297783614.19357.10.camel@localhost.localdomain>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
	<1297774735-32184-5-git-send-email-vinod.koul@intel.com>
	<2A84145621092446B6659B8A0F28E26F4703CC4477@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id AE13E244DD
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 16:18:01 +0100 (CET)
In-Reply-To: <2A84145621092446B6659B8A0F28E26F4703CC4477@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "Harsha, Priya" <priya.harsha@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-15 at 20:16 +0530, Bensaid, Selma wrote:
> > 
> > +static int sst_platform_pcm_hw_params(struct snd_pcm_substream
> > *substream,
> > +		struct snd_pcm_hw_params *params)
> > +{
> > +	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> > +	memset(substream->runtime->dma_area, 0,
> > params_buffer_bytes(params));
> > +
> > +	return 0;
> > +}
> > 
> >  static struct snd_pcm_ops sst_platform_ops = {
> >  	.open = sst_platform_open,
> > @@ -373,6 +381,7 @@ static struct snd_pcm_ops sst_platform_ops = {
> >  	.prepare = sst_platform_pcm_prepare,
> >  	.trigger = sst_platform_pcm_trigger,
> >  	.pointer = sst_platform_pcm_pointer,
> > +	.hw_params = sst_platform_pcm_hw_params,
> >  };
> 
> Hi Vinod,
> 
> The sst_soc_platform_drv provides also .pcm_new callback which pre-allocates 
> the DMA memory for the PCM Streams. Is the pcm_new callback required?
Selma,
Quoting Takshi's Writing alsa driver [1] "snd_pcm_lib_malloc_pages() is
available only when the DMA buffers have been pre-allocated".
The .pcm_new in this case allocates the buffer using
snd_pcm_lib_preallocate_pages_for_all and in .hw_params we use the
snd_pcm_lic_malloc_pages.
This seems to be required for aplay with mmap option to work (which pa
seems to use as well), otherwise the mmap call fails


-- 
~Vinod Koul
Intel Corp.

[1]:
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s06.html#pcm-interface-operators-open-callback
