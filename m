From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 10/11] ASoC: DaVinci: i2s don't limit
 rates
Date: Mon, 06 Jul 2009 15:01:54 -0700
Message-ID: <4A527452.6050304@boundarydevices.com>
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
	<20090705115746.GB5334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id BC5B82453E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:01:59 +0200 (CEST)
In-Reply-To: <20090705115746.GB5334@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Sat, Jul 04, 2009 at 07:30:00PM -0700, Troy Kisky wrote:
>> If the codec is master, we support anything
>> that the codec supports.
> 
> Hrm, tricky - the rate configuration doesn't depend on what is master so
> this could cause confusion if the codec is slave.
> 
>> -#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
>> +#define DAVINCI_I2S_RATES	(SNDRV_PCM_RATE_8000_96000 |\
>> +	SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS)
> 
> Note that the ASoC core doesn't support _KNOT or _CONTINUOUS (at least
> not properly) so the only thing you should get from this is 5512.  Is
> that really worth worrying about the master/slave problem?
> 
Ok. I'll drop this. I just needed it when I was testing all rates my codec supports.
Now that I've tested it, I don't think I'll ever use the other rates.

But even if the cpu is the clock/frame master, the sample rate generator has an 8 bit
divider field, which seems to be always 0 in the current code. And I don't see any reference
to params_rate in the davinci-i2s.c file. Has anyone tried the cpu as master???


Troy
