From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: utils - Add support for a dummy
	codec driver.
Date: Tue, 10 Jan 2012 04:41:19 +0000
Message-ID: <20120110044119.GQ30766@opensource.wolfsonmicro.com>
References: <1326112584-14942-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71045103AB9
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 05:41:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326112584-14942-1-git-send-email-lrg@ti.com>
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

On Mon, Jan 09, 2012 at 12:36:24PM +0000, Liam Girdwood wrote:
> This is useful to create dummy codec devices where we need to have some
> DAI links without a real Codec. e.g. could be used to represent dumb FM,
> MODEM, etc

I've applied this but I think we should move it into the CODECs
directory - I stubbed the platform out in here mostly because there
isn't a natural place to put a platform driver that's not associated
with a particular platform.  Does that sound sensible?

> +static struct snd_soc_dai_driver dummy_dai = {
> +		.name = "snd-soc-dummy-dai",
> +};

Also fixed the indentation here while applying.
