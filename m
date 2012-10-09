From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ALSA: ASoC: McASP: make AHCLK
	direction configurable
Date: Tue, 9 Oct 2012 16:21:15 +0900
Message-ID: <20121009072112.GZ8237@opensource.wolfsonmicro.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
 <1349356122-14794-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC61C265271
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:21:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349356122-14794-5-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Matt Porter <mporter@ti.com>, alsa-devel@alsa-project.org, lrg@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 03:08:41PM +0200, Daniel Mack wrote:
> Add a .set_sysclk function to pass the direction of the clock down to
> the driver. Only enable AHCLKX in the PDIR register when the CPU is
> driving the clock.

Applied, thanks.
