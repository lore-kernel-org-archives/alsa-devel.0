From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Wed, 6 Oct 2010 08:31:04 +0100
Message-ID: <20101006073104.GC17998@sirena.org.uk>
References: <20101005191359.GA23315@opensource.wolfsonmicro.com>
	<s5h4ocz6doz.wl%tiwai@suse.de>
	<20101006063401.GB17998@sirena.org.uk>
	<s5hzkur4x0g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DFECC24425
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 09:31:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkur4x0g.wl%tiwai@suse.de>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 06, 2010 at 09:10:23AM +0200, Takashi Iwai wrote:

> If the above difference is intentional, it should be commented
> somewhere.

Meh, yes.  Dimitris, please fix or add a comment as appropriate.

> > They also differ in the type of the cache variable.  You could do
> > something with macros but it'd not be terribly pleasant.

> Hm, this can be tricky.  Meanwhile, we could have it always int,
> instead of different types.  The amount of memory you save by
> supporting different size might be more than the waste of 3 bytes for
> 1 byte data array.

Given the size of the register maps for modern chips with visible DSPs
in them the overhead can be non-trivial.  Doing this also inhibits
operations like doing bulk writes of data from cache (which we don't do
right now but may wish to do in future) since the data can't just be
passed to the bus I/O functions so it's not purely a memory efficiency
thing.
