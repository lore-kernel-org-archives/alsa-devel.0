From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320aic3x: Let the codec hit
 SND_SOC_BIAS_OFF when idle
Date: Fri, 10 Sep 2010 13:00:17 +0100
Message-ID: <20100910120016.GL7259@rakim.wolfsonmicro.main>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60CA21039C5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 14:00:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284117812-8618-4-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 02:23:32PM +0300, Jarkko Nikula wrote:

> -	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
> +	if (aic3x->power)
> +		regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
> +				       aic3x->supplies);

This looks suspicious - doesn't it mean that the enable/disables won't
be balanced any more?  I'd expect to either see the disable being
uncondtional or the power flag being updated.  I could be missing
something, though.
