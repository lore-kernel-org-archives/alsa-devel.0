From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Sat, 12 Jul 2008 00:30:51 -0600
Message-ID: <20080712063051.GD23213@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807070932q108da172n117c0670238db8a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F99F249F9
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 08:30:55 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so6068337wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2008 23:30:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807070932q108da172n117c0670238db8a5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 07, 2008 at 12:32:29PM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> >  This is an I2S bus driver for the MPC5200 PSC device.  It is probably
> >  will not be merged as-is because it uses v1 of the ASoC API, but I want
> >  to get it out there for comments.
> >  ---
> We need to tie the two PSCs up like this to get the audio clock in via
> PSC1 and then have PSC2 generate the frame clock when the i2s data is
> transmitted.
> 
> Do you want a diff, or do you have a new version with DMA broken out?

You may as well send me the diff.  I can't promise that I'll actually
get it merged in, but I'll try.

g.
