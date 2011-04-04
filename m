From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v3] alsa-lib: fixed coverity
	reported	issues under "FORWARD_NULL" checker.
Date: Mon, 4 Apr 2011 10:18:23 +0100
Message-ID: <20110404091823.GA18247@sirena.org.uk>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 44D7E103927
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:18:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 11:53:57AM +0300, sudarshan.bisht@nokia.com wrote:

> This patch has fix for situations where variable can be NULL 
> but not been checked beforehand.

This description doesn't seem to match the patch...

> -	if (h == NULL)
> +	if (h)
>  		snd_dlclose(h);

This is a coding style change, the two conditions are equivalent.

>  			SNDERR("Invalid type for func %s definition", str);
> +			err = -EINVAL;
>  			goto _err;

This appears to be fixing an uninitialised return value error.

>  			return err;
>  		if (periods == 1)
>  			return -EINVAL;
> -		if (*period_time == 0) {
> +		if (period_time) {
>  			err = INTERNAL(snd_pcm_hw_params_get_period_time)(hw_params, period_time, NULL);
>  			if (err < 0)

This check alters the semantics - rather than checking if *period_time is
non-zero we now check to see if period_time is non-NULL, paying no
attention to the value if the pointer is set.

There was at least one relevant fix in there but lots of the changes are
as above.
