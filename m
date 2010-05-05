From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
 reset gpio handling
Date: Wed, 5 May 2010 12:28:03 +0100
Message-ID: <20100505112803.GE5754@opensource.wolfsonmicro.com>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA627246B3
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 13:27:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 05, 2010 at 01:02:03PM +0300, Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

> +	if (aic3x->gpio_reset >= 0) {
> +		gpio_set_value(aic3x->gpio_reset, 0);
> +		gpio_free(aic3x->gpio_reset);
> +	}

There is gpio_is_valid().
