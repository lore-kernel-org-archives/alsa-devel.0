From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
 snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 15:35:39 +0000
Message-ID: <20111122153539.GF6624@sirena.org.uk>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1642E103A48
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:35:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ECBBE59.2040703@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, timur@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 04:23:05PM +0100, Daniel Mack wrote:

> The bug is reproducible by setting the output volume to 50% before
> sending the device to suspend. After wakeup, amixer still reports the
> old volume level, but the codec is in fact set to 100%. Changing it to
> 50% doesn't do anything, but to any other level has an effect. This is
> clearly a cache sync bug, but the piece that's missing is the reason why
> my patch does the right thing.

That's very odd, not ringing any bells at all.  It's not like the
existing code is trying to do anything clever with skipping writes, it
just blasts in all the register values and it's affecting two different
registers.

In any case, the patch is moving to factor code out in favour of core
facilities so it's a good idea anyway.
