From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 4/4] Rename exports in mpc5200_dma.c
Date: Mon, 27 Apr 2009 21:09:10 +0100
Message-ID: <20090427200910.GC14626@sirena.org.uk>
References: <20090427164108.18211.44680.stgit@terra>
	<20090427164447.18211.42851.stgit@terra>
	<20090427193534.GA23567@rakim.wolfsonmicro.main>
	<9e4733910904271305h171f5e9dybdd560ae2c22c9bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7331610380E
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 22:09:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904271305h171f5e9dybdd560ae2c22c9bf@mail.gmail.com>
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
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 04:05:10PM -0400, Jon Smirl wrote:
> On Mon, Apr 27, 2009 at 3:35 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:

> > Why are you exporting these? ?They should all be accessed via...

> This is part of what is broken in the driver. I have later patches
> that fix it but those patches are more complex.

Could you go into more detail on this, please?  Why aren't you just
moving them directly to the vtable of the DMA driver?
