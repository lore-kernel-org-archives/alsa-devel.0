From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch v3 1/2] ASoC: add support for alc562[123]
	codecs
Date: Thu, 21 Oct 2010 09:28:09 -0700
Message-ID: <20101021162809.GG9447@opensource.wolfsonmicro.com>
References: <20101021104846.183611804@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D7F824154
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 18:28:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101021104846.183611804@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 21, 2010 at 12:44:37PM +0200, Arnaud Patard wrote:

> +static void alc5623_work(struct work_struct *work)
> +{
> +	struct snd_soc_codec *codec =
> +		container_of(work, struct snd_soc_codec, delayed_work.work);
> +	alc5623_set_bias_level(codec, codec->bias_level);
> +}

Like I said when reviewing the last version please remove this and do
the ramping of VMID in line where it's required instead - the framework
should support this well enough now.  Indeed...

> +	/* charge alc5623 caps */
> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
> +		alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +		codec->bias_level = SND_SOC_BIAS_ON;
> +		alc5623_set_bias_level(codec, codec->bias_level);

...it looks like it may just be that the delayed work and associated
stuff is left over and can be removed entirely.
