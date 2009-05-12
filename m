From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Tue, 12 May 2009 22:50:03 +0100
Message-ID: <20090512215003.GA11884@sirena.org.uk>
References: <4A03748B.1010302@gmail.com> <20090512160229.GK29889@sirena.org.uk>
	<4A09B528.9050109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DBFB324726
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 23:50:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A09B528.9050109@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 07:43:04PM +0200, Karl Beldan wrote:
> Mark Brown wrote:

> > I'm out of time to look at this today - I expect that the fix is
> > probably to move some version of the port reset change into this patch.

> I'd go for moving port reset into 2/4 (or 1/4 ?), 3/4 would just remove
> clk_disable(clk_i2s) and leave the FIFO flushes as is, and keeping 4/4.
> What do you say ?

That sounds reasonable - I've already applied your first patch to reset
everything on startup so no need to resend that (I forgot to push before
leaving work).  Might be as well to just merge the removal of the reset
into the patch to handle playback and capture separately but either way
is OK.

The suspend/resume change is fine.
