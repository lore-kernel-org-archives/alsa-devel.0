From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
Date: Tue, 26 May 2015 19:02:48 +0800
Message-ID: <20150526110246.GA13725@shlinux2>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk> <20150525151127.GA8184@Asurada>
 <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
 <20150525152424.GA8164@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C9A265068
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 13:03:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150525152424.GA8164@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 08:24:25AM -0700, Nicolin Chen wrote:
> On Mon, May 25, 2015 at 12:13:45PM -0300, Fabio Estevam wrote:
> > Hi Nicolin,
> > 
> > On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > 
> > > Hi Mark,
> > >
> > > Is that possible for you to provisionally revert this patch?
> > > I wanted to wait for the test result from Fabio or Zidan in
> > > the Cc list because I don't have a test environment for SPDIF
> > > even though this change seems to make sense.
> > 
> > I currently don't have access to a SPDIF receiver to test it.
> 
> Okay, let's wait for Zidan then. We only need to test the
> playback route of supporting sample rates.
> 
> Thanks
> Nicolin
I don't have the board which supported by community to test spdif out. So i used the imx7 board
and test it with internal branch.
I found that (txclk_df + 1) is better than txclk_df.
I suspect the patch for clk_round_rate() is not in our branch. Could you please tell me which
patch is for clk_round_rate? I want to cherry-pick it to our branch and test it.

Best Regards,
Zidan Wang
