From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH for-2.6.32] sound dapm: fix checking for external widgets
 bug
Date: Fri, 10 Jul 2009 22:39:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907102238150.4232@jikos.suse.cz>
References: <90B0CE4312136749B97EBEAF5764F87403C8F77A@ambarella-ex.ambarella.net> <20090710191925.GA5916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756984AbZGJUkW@vger.kernel.org>
In-Reply-To: <20090710191925.GA5916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rongrong Cao <rrcao@ambarella.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Jul 2009, Mark Brown wrote:

> I also notice that you've CCed trivial@kernel.org.  Please don't do that 
> except for things that can't possibly cause bugs - a change like this 
> doesn't really qualify since while the code clearly looks buggy it's 
> always possible that the code is just obscure.

Absolutely. 

Nevertheless, when the patch doesn't qualify for trivial queue, and I see 
proper maintainers being also involved, I just silently skip the patch, 
otherwise I just add proper maintainers to CC and don't apply it to 
trivial queue.

-- 
Jiri Kosina
SUSE Labs
