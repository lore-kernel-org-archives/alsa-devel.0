From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based
 rbtree	compression
Date: Tue, 3 May 2011 14:24:20 +0100
Message-ID: <20110503132420.GM1762@opensource.wolfsonmicro.com>
References: <s5hk4e9rwfm.wl%tiwai@suse.de>
	<20110502145814.GB1844@opensource.wolfsonmicro.com>
	<20110503094319.GA27833@sirena.org.uk>
	<s5h4o5crrux.wl%tiwai@suse.de>
	<20110503104701.GD1762@opensource.wolfsonmicro.com>
	<s5hzkn4qcro.wl%tiwai@suse.de>
	<20110503110205.GE1762@opensource.wolfsonmicro.com>
	<s5hliyoq8d3.wl%tiwai@suse.de>
	<20110503130259.GK1762@opensource.wolfsonmicro.com>
	<s5hhb9brkg8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07C8A103804
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 15:24:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb9brkg8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 03:18:47PM +0200, Takashi Iwai wrote:

> Yes, but the core doesn't give how linearly it's stored although its
> storing order influences on the bulk I/O behavior.  In other words,
> the patches try to put registers partly linearly in magical blocks.
> But it doesn't guarantee whether the cache block is aligned to what
> hardware prefers since it's behind the scene.

Eh?  I don't follow what you're saying at all, sorry.

The wire formats used by controllers are nailed down by the APIs for the
relevant buses and the rest of the register I/O infrastructure.  The
only extra bit the cache needs to worry about is the set of registers
which are present in a given chip and the cache already has information
about that (which is what I was telling Dimitris he should use in my
direct reply to the patch).
