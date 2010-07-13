From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/4] ASoC: DaVinci: pcm, fix underrun by using sram
Date: Tue, 13 Jul 2010 16:30:46 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7AADA0C@dbde02.ent.ti.com>
References: <1258415554-31069-1-git-send-email-troy.kisky@boundarydevices.com>
	<1258415554-31069-2-git-send-email-troy.kisky@boundarydevices.com>
	<1258415554-31069-3-git-send-email-troy.kisky@boundarydevices.com>
	<1258415554-31069-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1258415554-31069-4-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org" <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Troy,

On Tue, Nov 17, 2009 at 05:22:34, Troy Kisky wrote:
> Fix underruns by using dma to copy 1st to sram
> in a ping/pong buffer style and then copying from
> the sram to the ASP. This also has the advantage
> of tolerating very long interrupt latency on dma
> completion.
>
> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>

[...]

> +static int request_ping_pong(struct snd_pcm_substream *substream,
> +             struct davinci_runtime_data *prtd,
> +             struct snd_dma_buffer *iram_dma)
> +{
> +     dma_addr_t asp_src_ping;
> +     dma_addr_t asp_dst_ping;
> +     int link;
> +     struct davinci_pcm_dma_params *dma_data = prtd->params;
> +
> +     /* Request ram master channel */
> +     link = prtd->ram_channel = edma_alloc_channel(EDMA_CHANNEL_ANY,
> +                               davinci_pcm_dma_irq, substream,
> +                               EVENTQ_1);

What is the reason for choosing EVENTQ_1 for this channel? EVENTQ_0
is already being used for ASP channel.

I imagine it will be much easier to tune the queue usage in the system
if all of audio data was using the same queue.

I am working on a patch which lets platform specify the event queues
for audio DMA. I am not sure if I really need to make a provision for
two different queues to be specified - that's why I ask.

Thanks,
Sekhar
