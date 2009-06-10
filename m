From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Automatically set TDM if needed
	on	pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 13:18:44 +0100
Message-ID: <20090610121844.GC14632@sirena.org.uk>
References: <1244567590.7406.100.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8854B24367
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 14:18:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244567590.7406.100.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2009 at 02:13:10PM -0300, Daniel Ribeiro wrote:
> * Extend set_tdm_slot to allow the user to arbitrarily set the frame
>   width and active TX/RX slots.
> * Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
> * Makes SSCR0_MOD optional.
> * Automatically sets network mode when needed if set_tdm_slot was
>   never called.
> * Clears SSCR1_RWOT case SSCR0_MOD is set.
> * Updates magician.c and wm9081.c for the new set_tdm_slot()

Please split out the API change from the use of it in the PXA SSP driver
- just include enough to keep it building, then send a second patch
changing the internals of the SSP driver.  At the minute there's two
different changes in here.

>  static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
> -			       unsigned int mask, int slots)
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int frame_width)
>  {
>  	struct snd_soc_codec *codec = dai->codec;
>  	unsigned int aif1 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
> @@ -1219,7 +1219,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
>  
>  	aif1 |= (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
>  
> -	switch (mask) {
> +	switch (tx_mask) {
>  	case 1:
>  		break;
>  	case 2:

This is wrong, the WM9081 is a DAC only part so it should be paying
attention to the RX mask, not the TX one.  We also need to handle the
sample size here.

I've not checked the SSP code yet.
