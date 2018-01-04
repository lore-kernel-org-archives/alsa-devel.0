From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Date: Thu, 4 Jan 2018 11:07:33 -0800
Message-ID: <20180104190732.GA27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
 <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 01, 2018 at 04:17:20PM +0100, Maciej S. Szmigiero wrote:
> > AC97 configures some registers earlier to start a communication
> > with CODECs, so this patch moves those register settings to the
> > dai_probe() as well, along with other register configurations.
 
> This patch breaks AC'97 CODEC probing.
> 
> Namely, the fsl_ssi DAI probe callback is only called after the AC'97
> CODEC probe callback, so when you move SSI AC'97 startup to its DAI
> probe callback it won't be done yet when the CODEC is probed (and this
> requires a working AC'97 interface to successfully complete).

Hmm...What's the dependency here? Why is it required like this?
I am okay to put everything to a separate fsl_ssi_hw_init() and
move it back to the platform probe() though.
