From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about your DSP topic branch
Date: Thu, 17 Mar 2011 11:57:28 +0000
Message-ID: <20110317115727.GB31411@opensource.wolfsonmicro.com>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
	<20110125115113.GB13051@sirena.org.uk>
	<4D3FBDB1.90804@codeaurora.org>
	<20110126112004.GA5476@opensource.wolfsonmicro.com>
	<4D41E8FE.4070206@codeaurora.org>
	<20110131133015.GI5123@opensource.wolfsonmicro.com>
	<4D81B84E.1060607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EB18103806
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 12:57:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D81B84E.1060607@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 12:29:18AM -0700, Patrick Lai wrote:

> I see a flag "no_codec" defined in struct snd_soc_dai_link. Is that
> flag going to stay or just a temporary workaround?

That's actually not referenced at all at the minute so it's not even a
workaround and should be removed :) .  I'd not expect to use that for
this as a lot of the links that use this are something <-> CODEC ones, I
suspect that's an early merged bit of the DSP config propagation stuff
but I'd need to check.
