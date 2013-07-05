From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: Allow imx-pcm-{dma,
	fiq}.c to be modules
Date: Fri, 5 Jul 2013 23:58:21 +0200
Message-ID: <201307052358.22068.arnd@arndb.de>
References: <201307051745.16140.arnd@arndb.de>
 <201307052255.10765.arnd@arndb.de> <20130705211920.GK27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by alsa0.perex.cz (Postfix) with ESMTP id DC39C2658E5
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 23:58:37 +0200 (CEST)
In-Reply-To: <20130705211920.GK27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Friday 05 July 2013, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 10:55:10PM +0200, Arnd Bergmann wrote:
> > On Friday 05 July 2013, Mark Brown wrote:
> 
> > > Is this actually OK with the FIQ APIs?
> 
> > I don't know. Why wouldn't it?
> 
> It was the only reason I could think of why that'd have been done.

I looked in the log and found this part has been patched a couple
of times already, going back and forth between "bool" and "tristate",
always to fix build errors.

Please hold back for now, I'll try to reproduce on the bug on
the current torvalds tree first. I know it was broken in linux-next
as of a few weeks ago, but something else may have changed in the
meantime.

	Arnd
