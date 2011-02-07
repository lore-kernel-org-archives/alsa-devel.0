From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: neo1973_wm8753: Move lm4857
 specefic code to its own module
Date: Mon, 7 Feb 2011 11:50:21 +0000
Message-ID: <20110207115021.GC10564@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<1297033463-14577-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C38AE103819
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 12:50:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297033463-14577-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 12:04:18AM +0100, Lars-Peter Clausen wrote:

> +int lm4857_add_controls(struct snd_soc_codec *codec)
> +{
> +	return snd_soc_add_controls(codec, lm4857_controls,
> +				ARRAY_SIZE(lm4857_controls));
> +}
> +EXPORT_SYMBOL_GPL(lm4857_add_controls);

If you're moving this into a standalone driver it should be updated to
register as a CODEC.
