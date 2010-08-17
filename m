From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component - Drop board-n8x0.c
	changes
Date: Tue, 17 Aug 2010 11:12:49 +0100
Message-ID: <20100817101249.GB21985@rakim.wolfsonmicro.main>
References: <20100817093445.ade1b4a4.jhnikula@gmail.com>
	<1282028282-13264-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99D0B2445D
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 12:12:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282028282-13264-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 17, 2010 at 09:58:02AM +0300, Jarkko Nikula wrote:
> These will conflict with queued changes to board-n8x0.c coming from
> linux-omap tree. Only side effect from this dropping is that the integrated
> digital microphone on Nokia N810 will stop working when ASoC multi-component
> is merged.
> 
> As currently the N810 is not very usable in mainline, I consider this as a
> minor issue that can be fixed in linux-omap tree the after the
> multi-component is merged.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.  Note that m-c is now the mainline for ASoC.
