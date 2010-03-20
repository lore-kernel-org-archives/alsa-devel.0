From: Julia Lawall <julia@diku.dk>
Subject: Re: question about sound/oss/vidc.c
Date: Sat, 20 Mar 2010 19:00:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003201900490.20541@ask.diku.dk>
References: <Pine.LNX.4.64.1003162258230.26076@ask.diku.dk>
	<s5hocinh0jj.wl%tiwai@suse.de>
	<20100320174206.GD14470@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B524103817
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 19:01:02 +0100 (CET)
In-Reply-To: <20100320174206.GD14470@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Mar 2010, Russell King wrote:

> On Wed, Mar 17, 2010 at 08:25:52AM +0100, Takashi Iwai wrote:
> > I guess these should be adev->dma_out->flags instead.
> 
> Yes, I think so too.

Thanks. I sent a patch.

julia
