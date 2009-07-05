From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add davinci_i2s_prepare and shutdown
Date: Sun, 5 Jul 2009 13:17:42 +0100
Message-ID: <20090705121741.GD5334@sirena.org.uk>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3165E243AE
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 14:17:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
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

On Sat, Jul 04, 2009 at 07:29:59PM -0700, Troy Kisky wrote:
> If the codec is master then prepare should call
> mcbsp_start, not trigger.

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

This and 1-7 all look good, I've applied them.  For this one (and some
of the others) it might've been nice to include a few more words about
the why.

> +static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
> +               struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;

No need to bounce through rtd here or in prepare.
