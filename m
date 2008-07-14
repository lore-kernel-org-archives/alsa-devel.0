From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 17:53:04 +0100
Message-ID: <20080714165302.GG25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 62E53243D6
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 18:53:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <487B7B71.9060606@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 11:14:41AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > I'm finding it difficult to square these two statements - from an ASoC
> > point of view the main thing this patch is doing is adding a machine
> > driver and that's not something that's going to go away.  

> Jon's concern is that there is no straightforward way to build a kernel with
> multiple fabric drivers and have the right one chosen via the device tree.  This
> is just a limitation of the device tree model, and no one has come up with a
> good solution yet.

Indeed - I understand what the problem you guys have is, I just want to
make sure that there is a reasonable consensus among the PowerPC people
that this approach is OK to go in and won't create ructions.  The lack
of resolution on this issue makes me nervous about any proposed solution
where I haven't seen any explicit indication that the community is OK
with it.

Incidentally, nobody ever really commented on my suggestion to do
something DMI-like - you've already got the board type information
present in the device trees (in the model and compatible information in
the root nodes), all that's needed is an API to allow matching on it.

> The problem still exists in ASoC V2.  However, it's not anything that ASoC
> itself needs to be concerned with.  It's purely a PowerPC problem.

Right, I just want to be clear that you guys all understand what this
code does and that there won't be too many complaints after the fact.

> > ASoC has always called it a machine driver.

> Wait, I thought it's supposed to be called a fabric driver now?  On PowerPC, it
> should be called a fabric driver because we already have machine drivers.

I don't mind - you can call it what you like inside PowerPC-specific
code.
