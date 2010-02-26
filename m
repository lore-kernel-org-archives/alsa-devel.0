From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allow mulitple usage count of codec
	and cpu dai
Date: Fri, 26 Feb 2010 11:20:26 +0000
Message-ID: <20100226112026.GA18864@rakim.wolfsonmicro.main>
References: <1267143152-15861-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6238103A09
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:20:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267143152-15861-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 26, 2010 at 09:12:32AM +0900, Jassi Brar wrote:
> If we are to have a snd_soc_dai i.e, cpu_dai and codec_dai, shared among two
> or more dai_links we need to log the number of active users of the dai.
> For that, we change semantics of the snd_soc_dai.active flag from indicator
> to reference counter.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.
