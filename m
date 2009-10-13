From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: Serialize access to
	dapm_power_widgets()
Date: Tue, 13 Oct 2009 13:30:44 +0100
Message-ID: <20091013123044.GA11977@rakim.wolfsonmicro.main>
References: <1255326119-12281-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<1255326119-12281-2-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28EA41038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 14:30:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255326119-12281-2-git-send-email-ext-eero.nurkkala@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 08:41:59AM +0300, ext-eero.nurkkala@nokia.com wrote:

>  		}
>  	}
> -	mutex_unlock(&codec->mutex);
>  
>  	dapm_power_widgets(codec, event);
> +	mutex_unlock(&codec->mutex);
>  	dump_dapm(codec, __func__);
>  	return 0;
>  }

I would've said we should protect dump_dapm() here too but since it's
built out by default and I intend to kill it shortly there's no point in
respinning for that so I'll apply this - thanks!
