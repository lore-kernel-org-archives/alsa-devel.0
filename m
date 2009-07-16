From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/06] Fix compilation warning
	for	sound/soc/codecs/wm8400.c
Date: Thu, 16 Jul 2009 14:47:01 +0100
Message-ID: <20090716134701.GD26770@sirena.org.uk>
References: <20090716130958.28045.71072.sendpatchset@subratamodak.linux.ibm.com>
	<20090716132308.GC9656@rakim.wolfsonmicro.main>
	<s5hzlb4n44x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F35A103882
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 15:47:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzlb4n44x.wl%tiwai@suse.de>
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
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, alsa-devel@alsa-project.org, Subrata Modak <subrata@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Jaroslav Kysela <erex@perex.cz>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 03:34:06PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > In this case I suspect that whatever compiler you are using (none of
> > those I've tried with seem to be doing this) isn't able to figure out
> > that if we skip initialising the variable then we use exactly the same
> > condition to return from the function before we try to use the variable.

> I get compile warnings on gcc 4.4.0, too.

Ah, that's useful - my GCC 4.4 system is at home so I can't try that one
immediately.  Which architecture?
