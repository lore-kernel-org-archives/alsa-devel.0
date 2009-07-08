From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix NULL pointer dereference
 in __pxa2xx_pcm_hw_free
Date: Wed, 8 Jul 2009 18:35:10 +0100
Message-ID: <20090708173510.GA27898@rakim.wolfsonmicro.main>
References: <1247073866-14074-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1C1D243E2
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 19:35:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247073866-14074-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 08, 2009 at 07:24:26PM +0200, Daniel Mack wrote:
> Check for rtd->params->drcmr != NULL before accessing it.

> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Applied, thanks.
