From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Date: Thu, 4 Jan 2018 12:58:36 -0800
Message-ID: <20180104205834.GA8729@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
 <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
 <20180104190732.GA27975@Asurada-Nvidia>
 <61acf616-dd63-bccd-2c91-ce244b799f09@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61acf616-dd63-bccd-2c91-ce244b799f09@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 04, 2018 at 09:38:52PM +0100, Maciej S. Szmigiero wrote:

> > Hmm...What's the dependency here? Why is it required like this?

> And a AC'97 CODEC probe needs AC'97 communication to be working,
> since it has to detect the CODEC model, configure it, etc.

Okay. If the CODEC configurations depend on (or are done via)
the AC link, it has to be in this way then.

> > I am okay to put everything to a separate fsl_ssi_hw_init() and
> > move it back to the platform probe() though.
> 
> This could be a solution - I assume that by "everything" in the above
> sentence you mean (at least) enabling the AC'97 communication at the
> SSI.

All register configurations -- I was trying to move them to dai
probe() so a deferring probe or the platform remove() does not
need to revert these register configurations.
