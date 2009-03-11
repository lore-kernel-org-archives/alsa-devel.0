From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Wed, 11 Mar 2009 22:27:24 +0000
Message-ID: <20090311222723.GC7536@sirena.org.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E73E924415
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 23:27:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:17:00PM +0100, Philipp Zabel wrote:
> As soon as CONFIG_PXA25x is enabled, those macros only handle the PXA25x_SSP
> case, which is wrong most of the time (and always wrong on >=PXA27x).
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Applied, thanks.
