From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:19:23 +0000
Message-ID: <20100112141922.GJ1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5htyurmoof.wl%tiwai@suse.de>
	<20100112140834.GG1418@rakim.wolfsonmicro.main>
	<s5hk4vnmmv7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A9FB1038AE
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:19:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk4vnmmv7.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2010 at 03:14:20PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Yes, it's afe1c2cd71eb4e0fade720b5709722e7124f29c0.  None of my build
> > test configs appear to manage to cover both SPI and PM at the minute
> > which is why I didn't hit it.

> You can get it simply by make allyesconfig with ARM.

Yeah, I've added configs in so it should be covered now.  I've tended to
avoid all*config since I'm using the same test set for everything and it
tends to turn up far too many unrelated problems with some of the trees
I test regularly.
