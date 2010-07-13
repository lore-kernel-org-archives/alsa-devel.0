From: troy.kisky@boundarydevices.com
Subject: Re: [PATCH 4/4] ASoC: DaVinci: pcm,
	fix underrun by using sram
Date: Tue, 13 Jul 2010 14:01:00 -0500
Message-ID: <51883.1279047660@boundarydevices.com>
Reply-To: troy.kisky@boundarydevices.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sitemail.siteprotect.com (fw.mfg.onr.siteprotect.com
	[64.26.60.152]) by alsa0.perex.cz (Postfix) with ESMTP id 7BDE7243F6
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 21:01:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nori Sekhar <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "broonie@sirena.org.uk" <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

  BODY { font-family:Arial, Helvetica, sans-serif;font-size:12px; } 
 On Tue 13/07/10 6:00 AM , "Nori, Sekhar" nsekhar@ti.com sent:
	Hi Troy,
 On Tue, Nov 17, 2009 at 05:22:34, Troy Kisky wrote:
 > Fix underruns by using dma to copy 1st to sram
 > in a ping/pong buffer style and then copying from
 > the sram to the ASP. This also has the advantage
 > of tolerating very long interrupt latency on dma
 > completion.
 >
 > Signed-off-by: Troy Kisky 
 [...]
 > +static int request_ping_pong(struct snd_pcm_substream *substream,
 > + struct davinci_runtime_data *prtd,
 > + struct snd_dma_buffer *iram_dma)
 > +{
 > + dma_addr_t asp_src_ping;
 > + dma_addr_t asp_dst_ping;
 > + int link;
 > + struct davinci_pcm_dma_params *dma_data = prtd->params;
 > +
 > + /* Request ram master channel */
 > + link = prtd->ram_channel = edma_alloc_channel(EDMA_CHANNEL_ANY,
 > + davinci_pcm_dma_irq, substream,
 > + EVENTQ_1);
 What is the reason for choosing EVENTQ_1 for this channel? EVENTQ_0
 is already being used for ASP channel.
 I imagine it will be much easier to tune the queue usage in the
system
 if all of audio data was using the same queue.
 I am working on a patch which lets platform specify the event queues
 for audio DMA. I am not sure if I really need to make a provision
for
 two different queues to be specified - that's why I ask.
 Thanks,
 Sekhar
	The reason is so that the IRAM data can be fetched and used while 

	EVENTQ_1 fetches the next buffer of data from sdram into IRAM. 
	Troy 

	 
