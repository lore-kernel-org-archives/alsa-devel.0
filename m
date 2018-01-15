From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 13/16] ASoC: fsl_ssi: Clean up
	_fsl_ssi_set_dai_fmt()
Date: Sun, 14 Jan 2018 16:11:12 -0800
Message-ID: <20180115001111.GC2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-14-git-send-email-nicoleotsuka@gmail.com>
 <2e285df9-834b-41bf-1a09-a8de3f2a1f7c@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF67266CFE
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 01:11:16 +0100 (CET)
Received: by mail-pf0-f173.google.com with SMTP id t12so7258659pfg.2
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 16:11:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2e285df9-834b-41bf-1a09-a8de3f2a1f7c@maciej.szmigiero.name>
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

On Sun, Jan 14, 2018 at 11:40:31PM +0100, Maciej S. Szmigiero wrote:
> >  	case SND_SOC_DAIFMT_I2S:
> > -		regmap_update_bits(regs, REG_SSI_STCCR,
> > -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
> > -		regmap_update_bits(regs, REG_SSI_SRCCR,
> > -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
> >  		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> >  		case SND_SOC_DAIFMT_CBM_CFS:
> >  		case SND_SOC_DAIFMT_CBS_CFS:
> > +			if (IS_ERR(ssi->baudclk)) {
> > +				dev_err(ssi->dev,
> > +					"missing baudclk for master mode\n");
> > +				return -EINVAL;
> > +			}
> 
> The original code did this check only for fsl_ssi_is_i2s_master(ssi),
> that is, only for SND_SOC_DAIFMT_CBS_CFS while here you also do it for
> SND_SOC_DAIFMT_CBM_CFS.

You are right. This patch isn't supposed to change that. I mixed an
intention from another patch. Will revise this part in the v3.

Thanks a lot
