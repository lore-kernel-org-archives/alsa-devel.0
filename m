From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Factor out I2C 8 bit address 8
	bit	data I/O
Date: Mon, 7 Sep 2009 11:50:06 +0100
Message-ID: <20090907105005.GC23318@sirena.org.uk>
References: <4AA47845.8070403@samsung.com>
	<20090907101519.GA29898@rakim.wolfsonmicro.main>
	<s5hocpnxcl9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 55E6D103824
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 12:50:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hocpnxcl9.wl%tiwai@suse.de>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 07, 2009 at 12:40:02PM +0200, Takashi Iwai wrote:

> Where we are at it: Mark, could you fix the initialization of io_types[]
> in C99 style?  For this case, C99 style initialization is suited better
> since some fields are optional now.

Meh, I guess.

> Also, I find the current unbalanced hw_read/hw_write definitions uneasy.
> hw_read takes the codec instance while hw_write takes i2c instance
> (and hw_read_t is dead).  It'd be nice if you can fix these as well.

I don't think it's worth the pain until more of the drivers are using
the shared cache functions - making changes like that more
straightforward is one of the goals of doing this refactoring.
