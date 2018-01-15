From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 16/17] ASoC: fsl_ssi: Move DT related
 code to a separate probe()
Date: Mon, 15 Jan 2018 13:32:21 -0800
Message-ID: <20180115213221.GA10868@Asurada>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-17-git-send-email-nicoleotsuka@gmail.com>
 <0be4b57d-cb28-896a-3d97-f36316a351c5@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
 [209.85.160.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A5C2266BBC
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 22:32:30 +0100 (CET)
Received: by mail-pl0-f65.google.com with SMTP id 66so4561431plc.13
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 13:32:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0be4b57d-cb28-896a-3d97-f36316a351c5@maciej.szmigiero.name>
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

On Mon, Jan 15, 2018 at 10:16:39PM +0100, Maciej S. Szmigiero wrote:

> >  	/* Check if being used in AC97 mode */
> >  	sprop = of_get_property(np, "fsl,mode", NULL);
> > -	if (sprop) {
> > -		if (!strcmp(sprop, "ac97-slave"))
> > -			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> > +	if (sprop && !strcmp(sprop, "ac97-slave")) {
> > +		ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> > +
> > +		ret = of_property_read_u32(np, "cell-index", &ssi->card_idx);
> > +		if (ret) {
> > +			dev_err(dev, "failed to get SSI index property\n");
> > +			return -EINVAL;
> > +		}
> > +		strcpy(ssi->card_name, "ac97-codec");
> >  	}
> >  
> >  	/* Select DMA or FIQ */
> >  	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
> >  
> > +	/* In synchronous mode, STCK and STFS ports are used by RX as well */
> > +	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
> > +		ssi->synchronous = true;
> 
> You are setting ssi->synchronous in the AC'97 mode here, the old code
> didn't do that (see the next patch hunk below).

Will modify this part. Thanks
