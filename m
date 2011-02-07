From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: neo1973_wm8753: Remove scenario
 management code.
Date: Mon, 7 Feb 2011 11:42:55 +0000
Message-ID: <20110207114255.GB10564@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9083610380E
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 12:42:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297033463-14577-1-git-send-email-lars@metafoo.de>
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

On Mon, Feb 07, 2011 at 12:04:17AM +0100, Lars-Peter Clausen wrote:

> +	snd_soc_dapm_disable_pin(codec, "Audio Out");
> +	snd_soc_dapm_disable_pin(codec, "GSM Line Out");
> +	snd_soc_dapm_disable_pin(codec, "GSM Line In");
> +	snd_soc_dapm_disable_pin(codec, "Headset Mic");
> +	snd_soc_dapm_disable_pin(codec, "Call Mic");

This will mean that it's impossible to enable most (if not all) of the
audio paths in the system which probably isn't what you want.
