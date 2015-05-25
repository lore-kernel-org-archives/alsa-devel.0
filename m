From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
Date: Mon, 25 May 2015 08:24:25 -0700
Message-ID: <20150525152424.GA8164@Asurada>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
 <20150525151127.GA8184@Asurada>
 <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 12:13:45PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> 
> > Hi Mark,
> >
> > Is that possible for you to provisionally revert this patch?
> > I wanted to wait for the test result from Fabio or Zidan in
> > the Cc list because I don't have a test environment for SPDIF
> > even though this change seems to make sense.
> 
> I currently don't have access to a SPDIF receiver to test it.

Okay, let's wait for Zidan then. We only need to test the
playback route of supporting sample rates.

Thanks
Nicolin
