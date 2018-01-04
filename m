From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 01/15] ASoC: fsl_ssi: Clean up
	set_dai_tdm_slot()
Date: Thu, 4 Jan 2018 11:08:37 -0800
Message-ID: <20180104190836.GB27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
 <b910e12c-bee7-18ba-f878-bece9a9f9cc1@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f43.google.com (mail-pl0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 469EA267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 20:08:24 +0100 (CET)
Received: by mail-pl0-f43.google.com with SMTP id z5so1561522plo.10
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 11:08:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b910e12c-bee7-18ba-f878-bece9a9f9cc1@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 01, 2018 at 07:39:52PM +0100, Maciej S. Szmigiero wrote:

> >  	/* The slot number should be >= 2 if using Network mode or I2S mode */
> > -	regmap_read(regs, REG_SSI_SCR, &val);
> > -	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
> > -	if (val && slots < 2) {
> > +	if (ssi->i2s_net && slots < 2) {
> >  		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
> >  		return -EINVAL;
> >  	}
> 
> Are you sure that ssi->i2s_net SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET bits
> (also known as SSI_SCR_I2S_NET_MASK) zero or non-zero status is always
> consistent with that in the SCR register?
> 
> I can see that in fsl_ssi_hw_params() these bits in SCR are zeroed in
> a one special case and in the second special case they are hardcoded
> to SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET, in both cases regardless of
> what is currently in ssi->i2s_net.

You are right. I should update the i2s_net in hw_params() too. Thanks!
