From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for clock divisor
 calculation
Date: Mon, 25 May 2015 08:11:27 -0700
Message-ID: <20150525151127.GA8184@Asurada>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150525115812.GG21391@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, fabio.estevam@freescale.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 12:58:12PM +0100, Mark Brown wrote:
> On Sun, May 24, 2015 at 01:12:41AM -0700, Nicolin Chen wrote:
> > As commit 6c8ca30eec7b ("ASoC: fsl_ssi: Don't try to round-up for PM
> > divisor calculation") mentioned that there's no more need to use a
> > round up work around to get a better divisor since the clk-divider
> > driver has been refined a lot.
> 
> Applied, thanks.

Hi Mark,

Is that possible for you to provisionally revert this patch?
I wanted to wait for the test result from Fabio or Zidan in
the Cc list because I don't have a test environment for SPDIF
even though this change seems to make sense.

Thank you
Nicolin
