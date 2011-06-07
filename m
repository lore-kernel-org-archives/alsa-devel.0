From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Optimise and refactor
 pcm_new() to pass only rtd
Date: Tue, 7 Jun 2011 18:44:17 +0100
Message-ID: <20110607174416.GL18544@opensource.wolfsonmicro.com>
References: <1307459313-5078-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A434124588
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 19:44:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307459313-5078-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 04:08:33PM +0100, Liam Girdwood wrote:
> Currently pcm_new() passes in 3 arguments :- card, pcm and DAI.
> 
> Refactor this to only pass in 1 argument (i.e. the rtd) since struct rtd contains
> card, pcm and DAI along with other members too that are useful too.

Applied, thanks.
