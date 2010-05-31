From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/6] soc-dapm.h: add
	SND_SOC_DAPM_PRE_POST_PMD event
Date: Mon, 31 May 2010 12:20:41 +0100
Message-ID: <20100531112040.GG3489@rakim.wolfsonmicro.main>
References: <20100527125737.524554667@mandriva.com>
	<20100527130338.487101110@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DE922413B
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:20:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100527130338.487101110@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 27, 2010 at 02:57:40PM +0200, apatard@mandriva.com wrote:
> Some systems codecs need to configure some registers before and after powering down
> some of their part. As a convenience, I'm adding a macro for that.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Applied with modified changelog, thanks.

Please put an appropriate prefix on patches you submit ("ASoC: " for
ASoC) - this makes it easier to apply.
