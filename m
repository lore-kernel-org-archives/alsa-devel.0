From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Fri, 29 Jan 2010 10:13:08 +0000
Message-ID: <20100129101307.GA3201@rakim.wolfsonmicro.main>
References: <1264674858-27461-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA0651038B9
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 11:13:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264674858-27461-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2010 at 06:34:18PM +0800, Daniel Mack wrote:
> Invalidate the cached hardware format on resume for PXA SSP ports.
> Otherwise hw_params() will bail out early at the next stream start,
> leaving the registers in a bogus state.

Would it not be better to write the cached state back to the hardware?
Putting an invalid value in the cache seems like asking for trouble.
