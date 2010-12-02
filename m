From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/2] ASoC: core: Reordered DAPM update power
	on widgets
Date: Thu, 2 Dec 2010 12:21:28 +0000
Message-ID: <20101202122128.GA859@rakim.wolfsonmicro.main>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291291390-8669-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03EBA10383C
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:21:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291291390-8669-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 02, 2010 at 02:03:09PM +0200, Peter Ujfalusi wrote:

> +	unsigned int dapm_reorder_pupdate:1; /* Reordered pupdate in widgets */

Please use a more meaningful name than pupdate, I can't parse what that
stands for easily (I'm guessing power update?) and even with that it's
not clear what the option actually does.

> +	unsigned int change, dapm_pupdate_first = 1;

Please split the new variable onto a separate line - mixed initialised
and uninitialised variables are confusing to read.

> -	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
> -		if (val)
> -			/* new connection */
> -			connect = invert ? 0:1;
> -		else
> -			/* old connection must be powered down */
> -			connect = invert ? 1:0;
> +	change = snd_soc_test_bits(widget->codec, reg, val_mask, val);
> +	if (val)
> +		/* new connection */
> +		connect = invert ? 0 : 1;
> +	else
> +		/* old connection must be powered down */

This is really confusing - if there's no change why are we not just
exiting the function immediately?  It makes the rest of the code much
harder to follow as the conditionals all get more complex.
