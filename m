From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Tue, 02 Mar 2010 15:52:00 +0200
Message-ID: <1267537920.24345.7.camel@eenurkka-desktop>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B9511038EA
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:52:46 +0100 (CET)
In-Reply-To: <1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-02 at 14:39 +0100, Ujfalusi Peter (Nokia-D/Tampere)
wrote:
> New function for reading the XBUFFSTAT register, which holds
> the fill state of the transmit buffer on McBSP.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

Reading the XBUFFSTAT register is by no means accurate.
IIRC, it reports the buffer status incorrectly about 1/50 times
on average (@ 48000khz); with simple math, it may be read during the DMA
burst. Or is it guaranteed not being read during DMA transfer / have
you otherwise verified the behavior?

- Eero

>  arch/arm/plat-omap/include/plat/mcbsp.h |    4 ++++
>  arch/arm/plat-omap/mcbsp.c              |   27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index 4f22e5b..98de3d4 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -147,6 +147,8 @@
>  #define OMAP_MCBSP_REG_WAKEUPEN	0xA8
>  #define OMAP_MCBSP_REG_XCCR	0xAC
>  #define OMAP_MCBSP_REG_RCCR	0xB0
> +#define OMAP_MCBSP_REG_XBUFFSTAT	0xB4
> +#define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
>  
>  #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
>  #define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
> @@ -428,6 +430,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
>  void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
>  u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
>  u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
> +u16 omap_mcbsp_get_tx_buffstat(unsigned int id);
>  int omap_mcbsp_get_dma_op_mode(unsigned int id);
>  #else
>  static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
> @@ -436,6 +439,7 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
>  { }
>  static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
>  static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
> +static inline u16 omap_mcbsp_get_tx_buffstat(unsigned int id) { return 0; }
>  static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
>  #endif
>  int omap_mcbsp_request(unsigned int id);
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index f757672..e49af86 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -284,6 +284,33 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
>  EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
>  
>  /*
> + * omap_mcbsp_get_tx_buffstat returns the number of used slots in the McBSP FIFO
> + */
> +u16 omap_mcbsp_get_tx_buffstat(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u16 buffstat;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	/* Returns the number of free locations in the buffer */
> +	buffstat = OMAP_MCBSP_READ(mcbsp->io_base, XBUFFSTAT);
> +
> +	/* Number of free slots on McBSP ports */
> +	if (mcbsp->id == 2)
> +		buffstat = 0x500 - buffstat;
> +	else
> +		buffstat = 0x80 - buffstat;
> +
> +	return buffstat;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_get_tx_buffstat);
> +
> +/*
>   * omap_mcbsp_get_dma_op_mode just return the current configured
>   * operating mode for the mcbsp channel
>   */
