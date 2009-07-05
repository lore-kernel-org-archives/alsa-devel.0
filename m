From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 10/11] ASoC: DaVinci: i2s don't limit
 rates
Date: Sun, 5 Jul 2009 12:57:46 +0100
Message-ID: <20090705115746.GB5334@sirena.org.uk>
References: <1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85DDB24366
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 13:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 04, 2009 at 07:30:00PM -0700, Troy Kisky wrote:
> If the codec is master, we support anything
> that the codec supports.

Hrm, tricky - the rate configuration doesn't depend on what is master so
this could cause confusion if the codec is slave.

> -#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
> +#define DAVINCI_I2S_RATES	(SNDRV_PCM_RATE_8000_96000 |\
> +	SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS)

Note that the ASoC core doesn't support _KNOT or _CONTINUOUS (at least
not properly) so the only thing you should get from this is 5512.  Is
that really worth worrying about the master/slave problem?
