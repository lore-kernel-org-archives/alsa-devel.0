From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: DaVinci: Audio: Fix swapping of
	channels at start of stereo playback
Date: Thu, 13 Nov 2008 14:40:38 +0000
Message-ID: <20081113144036.GF31592@sirena.org.uk>
References: <1226465791-14725-1-git-send-email-naresh@ti.com>
	<20081112115001.GC8767@sirena.org.uk>
	<87prkzk871.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 05E9D103809
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:40:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87prkzk871.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, naresh@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 06:32:34AM -0800, Kevin Hilman wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> > Do you know what the status is on merging the DMA API that the ASoC
> > DaVinci driver uses into mainline?

> I'm the current maintainer of the DaVinci git kernel[1].  I am working
> on syncing the core code (including DMA) with mainline. I may have
> things ready for the next merge window, but if not, I'll definitely
> have it sync'd for the next one.

Ah, that's good news - we keep getting ASoC users confused by the fact
that the current ASoC driver doesn't build with mainline.  Thanks!
