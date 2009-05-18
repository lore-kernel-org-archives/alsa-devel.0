From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller
	driver	(v2)
Date: Mon, 18 May 2009 16:33:18 +0100
Message-ID: <20090518153317.GA27195@sirena.org.uk>
References: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20090518142305.GE1629@sirena.org.uk>
	<20090519.002542.39155238.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F86D24467
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:33:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090519.002542.39155238.anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 12:25:42AM +0900, Atsushi Nemoto wrote:

> Thank you for elaboration.  Then, this untested patch (on top of the
> last patch) is what you mean?  If yes, I will split this into arch
> part and driver part, and then update both patches.

Partly - I'd also expect to see the resources moved around in the
architecture code so that they are on the platform devices that are
being used to probe the DAIs (unless that's what the architecture side
of your patch was doing, patch wasn't quite giving me enough context to
be 100% clear).

You could also roll the resource requesting and unrequesting into the
probe functions for the DAI & DMA platform devices, though that is not
essential.
