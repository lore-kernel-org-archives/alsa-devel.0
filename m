From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fix stream restart error
Date: Tue, 26 Jan 2010 12:42:31 +0000
Message-ID: <20100126124231.GR15759@rakim.wolfsonmicro.main>
References: <1263987393-29886-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC100103813
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 13:42:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263987393-29886-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2010 at 05:06:33PM +0530, Chaithrika U S wrote:
> Sometimes after a suspend-resume cycle, the ALSA application
> restarts the stream when resume fails and McASP fails to work
> as the clock is not enabled. This patch corrects this bug.
> 
> Testes on TI DA850/OMAP-L138 EVM.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

Applied, thanks.
