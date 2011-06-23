From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix Blackfin I2S
 _pointer()	implementation return in bounds values
Date: Thu, 23 Jun 2011 21:10:31 +0200
Message-ID: <4E038FA7.40509@metafoo.de>
References: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A7623103803
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 21:12:12 +0200 (CEST)
In-Reply-To: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/23/2011 09:02 PM, Mark Brown wrote:
> [...]
> +	if (diff == snd_pcm_lib_buffer_bytes(substream))
> +		diff = 0;
> +	}
stray closing bracket

> +	frames = bytes_to_frames(substream->runtime, diff);
> +
>  	return frames;

Could be 'return bytes_to_frames(substream->runtime, diff);' directly
