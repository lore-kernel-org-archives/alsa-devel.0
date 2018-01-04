From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 03/15] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
Date: Thu, 4 Jan 2018 11:42:14 -0800
Message-ID: <20180104194213.GC27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-4-git-send-email-nicoleotsuka@gmail.com>
 <7509f512-1c7f-2fd2-e127-510106e2d9d5@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7509f512-1c7f-2fd2-e127-510106e2d9d5@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 01, 2018 at 10:29:24PM +0100, Maciej S. Szmigiero wrote:

> > @@ -445,16 +445,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
> >  	bool tx = &ssi->regvals[TX] == vals;

> > +	/* Check if the opposite stream is active */
> > +	aactive = ssi->streams & BIT(!tx);
> 
> I don't think that hardcoding an implicit assumption here that RX == 0,
> TX == 1 is a good thing.
> If in the future, for any reason, somebody changes values of these macros
> this code will silently break.
> 
> I would instead change this line into something like
> "aactive = ssi->streams & (tx ? BIT(RX) : BIT(TX));" or similar.

You have a point. I could add a "bool dir" to make it clear. Thanks.
