From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC Blackfin: fix bug - Audio Latency
	on AD1981	with MMAP enabled
Date: Sat, 27 Sep 2008 10:33:17 +0100
Message-ID: <20080927093316.GB3330@sirena.org.uk>
References: <1222505889-22287-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AADDC10383E
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 11:33:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222505889-22287-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 27, 2008 at 04:58:09PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>

> With MMAP enabled (DMA mode) on the AD1981, there is +/- 250ms of delay between
> writing data to alsa and audio starts coming out of the AD1981.
> 
> Copy more data to local buffer before starting DMA

> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but

> + * 
> + * Revision history
> + *      6th June 2008 Initial version
> + *      25th Sep 2008 fix latency when enable mmap
>   */

it'd be good to drop the in-code changelogs - we're already tracking the
history of the code with git and they're likely to end up providing an
inaccurate history due to people not updating them (this applies to most
of the Blackfin code).  There were in-code changelogs in ASoC in the past
from the time it was out of tree but they shouldn't be required now.
