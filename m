From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 04/16] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
Date: Sun, 14 Jan 2018 16:03:38 -0800
Message-ID: <20180115000337.GB2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-5-git-send-email-nicoleotsuka@gmail.com>
 <6dd7d3e8-4673-c56d-c0ce-80df1f537f9b@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6dd7d3e8-4673-c56d-c0ce-80df1f537f9b@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 14, 2018 at 11:34:37PM +0100, Maciej S. Szmigiero wrote:

> > +	/* Check if the opposite stream is active */
> > +	aactive = ssi->streams & BIT(!dir);
> 				     ^
> Here an implicit assumption that either RX == 0, TX == 1 or
> RX == 1, TX == 0 still remains.

I would try to get rid of this !dir. However the regvals is
defined as regvals[2] so this assumption (either RX == 0 or
TX == 0) doesn't look wrong to me. I would prefer to add a
comment to limit a potential modification to RX and TX.
