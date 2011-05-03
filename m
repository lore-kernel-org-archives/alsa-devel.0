From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based
 rbtree	compression
Date: Tue, 3 May 2011 14:02:59 +0100
Message-ID: <20110503130259.GK1762@opensource.wolfsonmicro.com>
References: <s5hoc3lrxaq.wl%tiwai@suse.de>
	<20110502144256.GA1656@opensource.wolfsonmicro.com>
	<s5hk4e9rwfm.wl%tiwai@suse.de>
	<20110502145814.GB1844@opensource.wolfsonmicro.com>
	<20110503094319.GA27833@sirena.org.uk>
	<s5h4o5crrux.wl%tiwai@suse.de>
	<20110503104701.GD1762@opensource.wolfsonmicro.com>
	<s5hzkn4qcro.wl%tiwai@suse.de>
	<20110503110205.GE1762@opensource.wolfsonmicro.com>
	<s5hliyoq8d3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6FF11037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 15:03:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hliyoq8d3.wl%tiwai@suse.de>
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

On Tue, May 03, 2011 at 02:25:12PM +0200, Takashi Iwai wrote:

> So, this is the preliminary work for implementing the bulk I/O?
> If so, it's worth to consider once whether implementing in the rb-tree
> cache code is the right choice.  Can it be implemented in the cache
> management core, since you'll need an API anyway for getting the bulk
> register array via cache manager?

The whole point of the caches is to be responsible for abstracting out
the in-memory layout of the data.  The core already provides information
that the caches can use about the register format and what registers are
present.

The other cache structures we have at the minute are fine since they
store everything as flat arrays anyway.
