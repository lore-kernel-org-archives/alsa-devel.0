From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 03/16] ASoC: fsl_ssi: Maintain a mask of active streams
Date: Sun, 14 Jan 2018 15:57:21 -0800
Message-ID: <20180114235720.GA2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
 <1488354c-99b0-fa64-a88c-0fa065df4b7d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488354c-99b0-fa64-a88c-0fa065df4b7d@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 14, 2018 at 11:34:01PM +0100, Maciej S. Szmigiero wrote:

> > +	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
> Using a bool variable for a bit index (and array index in other parts
> of code) looks just wrong.
> 
> Even a simple int would look better IMHO here (and in patch 5 that
> rewrites this line a bit).

Will change to int. Thanks
