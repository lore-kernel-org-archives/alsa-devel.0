From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] asoc tlv320aic3x: add more
	routing	controls
Date: Fri, 25 Apr 2008 11:57:57 +0100
Message-ID: <20080425105757.GC22926@rakim.wolfsonmicro.main>
References: <20080425091809.GA18518@buzzloop.caiaq.de>
	<s5hod7yl265.wl%tiwai@suse.de>
	<20080425093040.GB18558@buzzloop.caiaq.de>
	<s5hk5iml18d.wl%tiwai@suse.de>
	<1209119680.3286.167.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1D9B2470A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 12:57:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1209119680.3286.167.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 11:34:40AM +0100, Liam Girdwood wrote:

> The main problem I think we have on phones is that the audio routing is
> incredibly complex compared to a PC. i.e. a lot of mixers/controls have
> to be changed when we have a use case change.

It's also proved a substantial win for users to be able to use
interactive applications like alsamixer to set up the audio paths that
they need for their system rather than having to write kernel code -
it's much less of a learning curve for people for whom audio is just one
part of the system they're trying to put together.

I guess the other thing with the sort of systems that use ASoC is that
it's generally only developers who ever see the actual ALSA API in the
sort of systems that use ASoC.  Unlike desktop systems end users will
typically see a device or application specific user interface of some
kind that shows them only a very small subset of the available controls.
