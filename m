From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Clean up ASOC functions to support 32b
	values instead of 16b
Date: Thu, 24 Jul 2008 10:36:35 +0100
Message-ID: <20080724093630.GA3444@sirena.org.uk>
References: <20080723233635.6900.55269.stgit@terra>
	<ed82fe3e0807231841s2489781fr7515cd0bd0195586@mail.gmail.com>
	<9e4733910807231908s449922adtd24f911d467d51fd@mail.gmail.com>
	<ed82fe3e0807232055t3ab09348x789959c834784ca2@mail.gmail.com>
	<9e4733910807232105x7cca4c95x66906f67e68c7c29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B13A624942
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 11:36:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807232105x7cca4c95x66906f67e68c7c29@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 24, 2008 at 12:05:59AM -0400, Jon Smirl wrote:

> I think I may need to redo this with u32. I'm still working on my
> read/write reg routines and it is not obvious that it would adjust

I certainly agree with Timur that 'uint' and similar should be avoided
for consistency with the rest of the code.

> right on a 64b machine. Just because you switch to a 64b machine, my
> sound hardware is still 32b.

This is less important than it might seem - drivers generally serialise
written values into wire format prior to writing them to the chip so the
actual size the data comes in doesn't make much odds.
