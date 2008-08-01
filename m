From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 17:40:31 +0100
Message-ID: <20080801164031.GC11735@sirena.org.uk>
References: <9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de>
	<20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
	<9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
	<20080801161613.GA2076@rakim.wolfsonmicro.main>
	<9e4733910808010927j1da77ed2q3bf7d8cfcf0108fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ECC3244D0
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 18:40:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910808010927j1da77ed2q3bf7d8cfcf0108fe@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 12:27:27PM -0400, Jon Smirl wrote:

> Why would ASoC care about the holes in my sparse register list? You
> can't use this info for suspend/resume, my registers are variable
> length too. I need quite a bit of information to build a cache of
> sparse variable length registers.

Well, this function here is one example - any other diagnostic output
for registers will have the same issue, such as the more detailed
information about register/control mapping which I talked about in my
previous e-mail.
