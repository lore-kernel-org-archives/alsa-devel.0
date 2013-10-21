From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: dmaengine: Use filter_data rather
 than dma_data for compat requests
Date: Mon, 21 Oct 2013 09:03:29 +0800
Message-ID: <20131021010327.GD17165@S2101-09.ap.freescale.net>
References: <1382215106-31069-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DDB9A264FF9
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 03:02:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1382215106-31069-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 19, 2013 at 09:38:26PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> When using the legacy filter function channel requests we currently pass
> the audio specific struct snd_dmaengine_dai_dma_data which isn't likely to
> be helpful for actual filtering. Since there's already a field in the
> structure called filter_data clearly intended for use here convert the
> driver to use that.
> 
> All existing users of plain filter functions have been converted to use
> an explict compat function to override this behaviour except i.MX which
> is working around this issue in its filter function and is updated to
> just use filter_data directly here.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
