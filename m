From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 4/5] [RFC] ALSA ASOC adds destination and
 source port for dma
Date: Mon, 29 Sep 2008 14:06:42 +0300
Message-ID: <20080929140642.2be080ff.jarkko.nikula__21982.2780731649$1222686528$gmane$org@nokia.com>
References: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Sep 2008 15:23:52 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> Adds destination and source ports for dma which is required for OMAP1
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  sound/soc/omap/omap-pcm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
>  	err = omap_request_dma(dma_data->dma_req, dma_data->name,
>  			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
> +
>  	if (!cpu_is_omap1510()) {

Accidentally added line? Actually it pointed out that line after it
should include test for err before linking channel with itself.

	if (!err && !cpu_is_omap1510()) {

> +		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
>  	} else {
...
> +		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
>  	}

I don't have OMAP1 HW at hand to test but looks ok to me. And this port
variable is used only with OMAP1's.


Jarkko
