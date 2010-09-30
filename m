From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8804: Initial driver
Date: Thu, 30 Sep 2010 13:34:04 -0700
Message-ID: <20100930203403.GB4175@opensource.wolfsonmicro.com>
References: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61D66103968
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 22:33:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010 at 11:14:56AM +0100, Dimitris Papastamos wrote:

> The WM8804 is a high performance consumer mode
> S/PDIF transceiver with support for 1 received channel and
> 1 transmitted channel.

> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Applied, thanks but...

> +static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
> +			  int source, unsigned int freq_in,
> +			  unsigned int freq_out)
> +{
> +	int ret;
> +	struct snd_soc_codec *codec;
> +	struct pll_div pll_div = { 0 };

...please provide an incremental patch which fixes this to not override
all the flow control testing as discussed for your other patch.
